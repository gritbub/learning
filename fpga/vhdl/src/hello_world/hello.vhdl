-- Taken from the documentation for GHDL.
-- See https://github.com/gritbub/learning/blob/master/fpga/vhdl/Sources.md
--    for license info.


-- Imports the standard textio package.
use std.textio.all;

-- Defines a design entity, without any ports.
entity hello_world is
end hello_world;

architecture behavior of hello_world is
begin
   process
      variable l : line;
   begin
      write (l, String'("Hello world!"));
      writeline (output, l);
      wait;
   end process;
end behavior;