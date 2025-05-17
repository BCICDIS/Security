with Ada.Text_IO;
with Ada.Directories;
with Ada.Calendar;
with Ada.Calendar.Formatting;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with GNAT.OS_Lib;
with Ada.Streams.Stream_IO;
procedure Monitor_Daemon is
   Log_File : Ada.Text_IO.File_Type;
   procedure Delay_Seconds (Seconds : Positive) is
      use Ada.Calendar;
      Start_Time : Time := Clock;
   begin
      loop
         exit when Clock >= Start_Time + Duration(Seconds);
      end loop;
   end Delay_Seconds;
   procedure Write_Log (Message : String) is
   begin
      Ada.Text_IO.Put_Line(Log_File, "[" & Ada.Calendar.Formatting.Image(Ada.Calendar.Clock) & "] " & Message);
   end Write_Log;
   function Run_Command (Cmd : String) return String is
      use GNAT.OS_Lib;
      use Ada.Text_IO;

      Output_File : constant String := "cmd_output.tmp";
      Args : Argument_List_Access := Argument_String_To_List(Cmd);
      Success : Boolean;
      Return_Code : Integer;
      Output_Content : Unbounded_String := Null_Unbounded_String;
      F : File_Type;
   begin
      -- Execute command and redirect output to temporary file
      Spawn(
         Program_Name => Args(Args'First).all,
         Args => Args(Args'First + 1 .. Args'Last),
         Output_File => Output_File,
         Return_Code => Return_Code,
         Success => Success
      );

      -- Read the output file if command succeeded
      if Success and then Ada.Directories.Exists(Output_File) then
         Open(F, In_File, Output_File);
         while not End_Of_File(F) loop
            Append(Output_Content, Get_Line(F));
            if not End_Of_File(F) then
               Append(Output_Content, ASCII.LF);
            end if;
         end loop;
         Close(F);
         Ada.Directories.Delete_File(Output_File);
      end if;

      Free(Args);
      return To_String(Output_Content);
   exception
      when others =>
         Free(Args);
         if Is_Open(F) then
            Close(F);
         end if;
         if Ada.Directories.Exists(Output_File) then
            Ada.Directories.Delete_File(Output_File);
         end if;
         return "Error running command: " & Cmd;
   end Run_Command;
   procedure Count_Files (Dir : String) is
      Count     : Natural := 0;
      Search    : Ada.Directories.Search_Type;
      Dir_Entry : Ada.Directories.Directory_Entry_Type;
      Filter    : constant Ada.Directories.Filter_Type :=
                    (Ada.Directories.Ordinary_File => True, others => False);
   begin
      Ada.Directories.Start_Search(Search, Dir, "*", Filter);
      while Ada.Directories.More_Entries(Search) loop
         Ada.Directories.Get_Next_Entry(Search, Dir_Entry);
         Count := Count + 1;
      end loop;
      Ada.Directories.End_Search(Search);
      Write_Log("Files in " & Dir & ": " & Count'Img);
   exception
      when others => Write_Log("Failed to count files in " & Dir);
   end Count_Files;
begin
   -- Open log file
   Ada.Text_IO.Create(Log_File, Ada.Text_IO.Out_File, "monitor_log.txt");
   loop
      Write_Log("=== SYSTEM MONITOR LOOP START ===");
      -- Monitor file count
      Count_Files("C:\Users\Vilma E. Agripo\Music\Musics");
      -- Storage info
      Write_Log("Storage: " & Run_Command("df -h / | tail -n 1"));
      -- Memory info
      Write_Log("Memory: " & Run_Command("free -h | grep Mem"));
      -- CPU info
      Write_Log("CPU: " & Run_Command("top -bn1 | grep 'Cpu(s)'"));
      -- Recent logs
      Write_Log("Logs: " & Run_Command("dmesg | tail -n 1"));
      Delay_Seconds(10); -- every 10 seconds
   end loop;
end Monitor_Daemon;
