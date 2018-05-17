------------------------------------------------------------------------
--	
--	Title		:	mine.basic_logic
--	
--	Developers	:	https://github.com/gritbub
--	
--	Purpose		:	To copy ieee.std_logic_1164 manually as a learning
--					exercise. Also to build a smaller version of
--					std_logic_1164 which contains only a subset of the
--					original functions/types.
--	
--	License:	:	This is a direct copy of some of the ieee standard.
--					The original source is linked to at https://github.com/gritbub/learning/blob/master/fpga/vhdl/Sources.md.
--					See source for original license information.
--	
--	Content		:	package bodies	:	basic_logic
--					types			:	std_ulogic
--										std_ulogic_vector
--										std_logic
--										std_logic_vector
--										X01
--										UX01
--					functions		:	resolved
--										"and"
--										"nand"
--										"or"
--										"nor"
--										"xor"
--										"not"
--										To_bit
--										To_X01
--										rising_edge
--										falling_edge
--	
------------------------------------------------------------------------

package basic_logic is
	
	--------------------------------------------------------------------
	--	types defined in std, included with the compiler; not to be 'use'd
	--------------------------------------------------------------------
	-- type BIT is ( '0', '1' )
	-- type BOOLEAN is ( FALSE, TRUE );
	
	--------------------------------------------------------------------
	--	logic state system (unresolved)
	--------------------------------------------------------------------
	type std_ulogic is (	'U', 	--	Uninitialized
							'X', 	--	Forcing	Unknown
							'0', 	--	Forcing	0
							'1', 	--	Forcing	1
							'Z', 	--	High Impedance
							'W', 	--	Weak	Unknown
							'L', 	--	Weak	0
							'H', 	--	Weak	1
							'-' 	--	Don't care
	);
	
	--------------------------------------------------------------------
	--	unconstrained array of std_ulogic for use with the resolution
	--	function
	--------------------------------------------------------------------
	type std_ulogic_vector is array ( natural range <> ) of std_ulogic;
	
	--------------------------------------------------------------------
	--	resolution function
	--------------------------------------------------------------------
	function resolved ( s : std_ulogic_vector ) return std_ulogic;
	
	--------------------------------------------------------------------
	--	*** industry standard logic type ***
	--	I still recommend using std_ulogic so that you'll get compiler
	--	errors when multiple drivers occur for one signal.
	--------------------------------------------------------------------
	subtype std_logic is resolved std_ulogic;
	
	--------------------------------------------------------------------
	--	unconstrained array of std_logic for use in declaring signal
	--	arrays
	--------------------------------------------------------------------
	type std_logic_vector is array ( natural range <> ) of std_logic;
	
	--------------------------------------------------------------------
	--	common subtypes
	--------------------------------------------------------------------
	subtype X01		is resolved std_ulogic range 'X' to '1'; -- (	 'X','0','1')
	subtype UX01	is resolved std_ulogic range 'U' to '1'; -- ('U','X','0','1')
	
	--------------------------------------------------------------------
	--	overloaded logical operators
	--------------------------------------------------------------------
	function "and"	( l : std_ulogic; r : std_ulogic ) return UX01;
	function "nand"	( l : std_ulogic; r : std_ulogic ) return UX01;
	function "or"	( l : std_ulogic; r : std_ulogic ) return UX01;
	function "nor"	( l : std_ulogic; r : std_ulogic ) return UX01;
	function "xor"	( l : std_ulogic; r : std_ulogic ) return UX01;
	function "not"	( l : std_ulogic ) return UX01;
	
	--------------------------------------------------------------------
	--	vectorized overloaded logical operators
	--------------------------------------------------------------------
	function "and" 	( l, r : std_logic_vector	) return std_logic_vector;
	function "and" 	( l, r : std_ulogic_vector	) return std_ulogic_vector;
	
	function "nand"	( l, r : std_logic_vector	) return std_logic_vector;
	function "nand"	( l, r : std_ulogic_vector	) return std_ulogic_vector;
	
	function "or"	( l, r : std_logic_vector	) return std_logic_vector;
	function "or"	( l, r : std_ulogic_vector	) return std_ulogic_vector;
	
	function "nor"	( l, r : std_logic_vector	) return std_logic_vector;
	function "nor"	( l, r : std_ulogic_vector	) return std_ulogic_vector;
	
	function "xor"	( l, r : std_logic_vector	) return std_logic_vector;
	function "xor"	( l, r : std_ulogic_vector	) return std_ulogic_vector;
	
	function "not"	( l : std_logic_vector	) return std_logic_vector;
	function "not"	( l : std_ulogic_vector	) return std_ulogic_vector;
	
	--------------------------------------------------------------------
	--	conversion functions
	--------------------------------------------------------------------
	function To_bit ( s : std_ulogic; xmap : BIT := '0' ) return BIT;
	
	--------------------------------------------------------------------
	--	strength strippers and type converters
	--------------------------------------------------------------------
	function To_X01 ( s : std_ulogic ) return X01;
	
	--------------------------------------------------------------------
	--	edge detection
	--------------------------------------------------------------------
	function rising_edge	( signal s : std_ulogic ) return BOOLEAN;
	function falling_edge	( signal s : std_ulogic ) return BOOLEAN;
	
end basic_logic;

