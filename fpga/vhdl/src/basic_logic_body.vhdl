------------------------------------------------------------------------
--
--	Title		:	basic_logic
--	Library		:	This package shall be compiled into a library
--				:	symbolically named mine.
--				:
--	Developers	:	IEEE model standards group (par 1164)
--	(Original)	:
--	Developers	:	https://github.com/gritbub
--	(this copy)	:
--	Purpose		:	To provide only the parts of std_logic_1164 that
--				:	I'm using. Also to learn what comprises the
--				:	standard by retracing its contents.
--				:
--	Limitation	:	See original below.
--				:
--	Note		:	Copied from parts of ieee.std_logic_1164. See
--				:	original documenation for std_logic_1164 at the end
--				:	of this file.
--
------------------------------------------------------------------------

package body basic_logic is
	
	--------------------------------------------------------------------
	--	local types
	--------------------------------------------------------------------
	type stdlogic_table is array ( std_ulogic, std_ulogic ) of std_ulogic;
	
	--------------------------------------------------------------------
	--	resolution function
	--------------------------------------------------------------------
	constant resolution_table : stdlogic_table := (
		--	   U	X	 0	  1	   Z	W	 L	  H	   -
			( 'U', 'U', 'U', 'U', 'U', 'U', 'U', 'U', 'U' ), -- U
			( 'U', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X' ), -- X
			( 'U', 'X', '0', 'X', '0', '0', '0', '0', 'X' ), -- 0
			( 'U', 'X', 'X', '1', '1', '1', '1', '1', 'X' ), -- 1
			( 'U', 'X', '0', '1', 'Z', 'W', 'L', 'H', 'X' ), -- Z
			( 'U', 'X', '0', '1', 'W', 'W', 'W', 'W', 'X' ), -- W
			( 'U', 'X', '0', '1', 'L', 'W', 'L', 'W', 'X' ), -- L
			( 'U', 'X', '0', '1', 'H', 'W', 'W', 'H', 'X' ), -- H
			( 'U', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X' ), -- -
	);
	
	function resolved ( s : std_ulogic_vector ) return std_ulogic is
		variable result : std_ulogic := 'Z';	-- weakest state default
	begin
		--	The test for a single driver is essential otherwise the loop
		--	would return 'X' for a single driver of '-' and that would
		--	conflict with the value of a single driver unresolved
		--	signal.
		if ( s'length = 1 ) then
			return s(s'low);
		else
			for i in s'range loop
				result := resolution_table( result, s(i) );
			end loop;
		end if;
		return result;
	end resolved;
	
	--------------------------------------------------------------------
	--	tables for logical operations
	--------------------------------------------------------------------
	
	--	truth table for "and" function
	constant and_table : stdlogic_table := (
		--	   U	X	 0	  1	   Z	W	 L	  H	   -
			( 'U', 'U', '0', 'U', 'U', 'U', '0', 'U', 'U', ), -- U
			( 'U', 'X', '0', 'X', 'X', 'X', '0', 'X', 'X', ), -- X
			( '0', '0', '0', '0', '0', '0', '0', '0', '0', ), -- 0
			( 'U', 'X', '0', '1', 'X', 'X', '0', '1', 'X', ), -- 1
			( 'U', 'X', '0', 'X', 'X', 'X', '0', 'X', 'X', ), -- Z
			( 'U', 'X', '0', 'X', 'X', 'X', '0', 'X', 'X', ), -- W
			( '0', '0', '0', '0', '0', '0', '0', '0', '0', ), -- L
			( 'U', 'X', '0', '1', 'X', 'X', '0', '1', 'X', ), -- H
			( 'U', 'X', '0', 'X', 'X', 'X', '0', 'X', 'X', ), -- -

	);
	
	--------------------------------------------------------------------
	--	overloaded logical operators ( with optimizing hints )
	--------------------------------------------------------------------
	function "and"	( l : std_ulogic; r : std_ulogic ) return UX01 is
	begin
		return ( and_table( l, r ) );
	end "and";
	
	--------------------------------------------------------------------
	--	and
	--------------------------------------------------------------------
	function "and"	( l, r : std_logic_vector ) return std_logic_vector is
		alias lv : std_logic_vector ( 1 to l'length ) is l;
		alias rv : std_logic_vector ( 1 to r'length ) is r;
		variable result : std_logic_vector ( 1 to l'length );
	begin
		if ( l'length /= r'length ) then
			assert false
			report "arguments of overloaded 'and' operator are not of the same length"
			severity failure;
		else
			for i in result'range loop
				result(i) := and_table ( lv(i), rv(i) );
			end loop;
		end if;
	end "and";
	--------------------------------------------------------------------
	function "and"	( l, r : std_ulogic_vector ) return std_ulogic_vector is
		alias lv : std_ulogic_vector ( 1 to l'length ) is l;
		alias rv : std_ulogic_vector ( 1 to r'length ) is r;
		variable result : std_ulogic_vector ( 1 to l'length );
	begin
		if ( l'length /= r'length ) then
			assert false
			report "arguments of overloaded 'and' operator are not of the same length"
			severity failure;
		else
			for i in result'range loop
				result(i) := and_table ( lv(i), rv(i) );
			end loop;
		end if;
	end "and";
	
end basic_logic;


-- Copy of original documenation:
-- --------------------------------------------------------------------
--
--   Title     :  std_logic_1164 multi-value logic system
--   Library   :  This package shall be compiled into a library
--             :  symbolically named IEEE.
--             :
--   Developers:  IEEE model standards group (par 1164)
--   Purpose   :  This packages defines a standard for designers
--             :  to use in describing the interconnection data types
--             :  used in vhdl modeling.
--             :
--   Limitation:  The logic system defined in this package may
--             :  be insufficient for modeling switched transistors,
--             :  since such a requirement is out of the scope of this
--             :  effort. Furthermore, mathematics, primitives,
--             :  timing standards, etc. are considered orthogonal
--             :  issues as it relates to this package and are therefore
--             :  beyond the scope of this effort.
--             :
--   Note      :  No declarations or definitions shall be included in,
--             :  or excluded from this package. The "package declaration"
--             :  defines the types, subtypes and declarations of
--             :  std_logic_1164. The std_logic_1164 package body shall be
--             :  considered the formal definition of the semantics of
--             :  this package. Tool developers may choose to implement
--             :  the package body in the most efficient manner available
--             :  to them.
--             :
-- --------------------------------------------------------------------
--   modification history :
-- --------------------------------------------------------------------
--  version | mod. date:|
--   v4.200 | 01/02/91  |
-- --------------------------------------------------------------------