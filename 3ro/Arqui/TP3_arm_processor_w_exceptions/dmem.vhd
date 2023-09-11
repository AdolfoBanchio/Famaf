-- File        : dmem.vhd
-- Modificada para el uso en el ejercicio 2 del laboratorio

-- dump: si esta señal esta activa (1), se copia le contenido de la memoria
-- en el archivo de salida DUMP (para su posterior revision).

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use STD.TEXTIO.all;
use IEEE.STD_LOGIC_SIGNED.all;
use ieee.numeric_std.all;

entity dmem is -- data memory	
   port(clk, memWrite, memRead:  in STD_LOGIC;
       address :    in STD_LOGIC_VECTOR(7 downto 0);
		 writeData :    in STD_LOGIC_VECTOR(64-1 downto 0);
       readData:       out STD_LOGIC_VECTOR(64-1 downto 0);
       dump: in STD_LOGIC
		 );
end;

architecture behave of dmem is
 constant MAX_BOUND: Integer := 256;
 constant MEMORY_DUMP_FILE: string := "mem.dump";
 
 type ramtype is array (0 to MAX_BOUND-1) of STD_LOGIC_VECTOR(64-1 downto 0);
 
 signal mem: ramtype := ( 
  0    =>  x"0000000000000400",
  1    =>  x"0000000000000030",
  128  =>  x"0000000000FFD000",
  129  =>  x"0000000000000002",
  130  =>  x"0000000000000002",
  131  =>  x"0000000000000098",    
  132  =>  x"00000000000000B8",
  133  =>  x"00000000000000A0",
  134  =>  x"0000000000C0CA00",
  135  =>  x"0000000000000005",
  136  =>  x"0000000000000004",
  137  =>  x"0000000000000060",
  138  =>  x"0000000000000088",
  139  =>  x"0000000000000070",
  140  =>  x"0000000000CAFE00",
  141  =>  x"0000000000000006",
  142  =>  x"0000000000000005",
  143  =>  x"0000000000000010",
  144  =>  x"0000000000000058",
  145  =>  x"0000000000000020", 
  others => x"0000000000000000");

 procedure memDump is
--   file dumpfile : text open write_mode is MEMORY_DUMP_FILE;
   FILE dumpfile: TEXT IS OUT MEMORY_DUMP_FILE;
   variable dumpline : line;
   variable i: natural := 0;
   begin
		write(dumpline, string'("Memoria RAM de Arm:"));
		writeline(dumpfile,dumpline);
		write(dumpline, string'("Address Data"));
		writeline(dumpfile,dumpline);
      while i <= MAX_BOUND-1 loop        
		  write(dumpline, i);
		  write(dumpline, string'(" "));
		  hwrite(dumpline, to_bitvector(mem(i)));		  
		  writeline(dumpfile,dumpline);
        i:=i+1;
      end loop;
		assert false report "fin del testdump" severity note;
   end procedure memDump;

begin
   process(clk, address, mem, memWrite, memRead)
	begin 
	  if clk'event and clk = '1' and memWrite = '1' then
				mem(conv_integer("0" & address(7 downto 0))) <= writeData;
	  end if;
	  if memRead = '1' then
			readData <= mem(conv_integer("0" & address(7 downto 0))); -- word aligned
	  else
			readData <= (others => '0');
	  end if;
	end process;
	
	process(dump)
	begin
	 if dump = '1' then
	   memDump;
	 end if;
	end process;
end;
