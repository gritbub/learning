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
--	Note		:	Copied from parts of ieee.std_logic_1164.
--
------------------------------------------------------------------------

package basic_logic is
	
	--------------------------------------------------------------------
	--	
	--------------------------------------------------------------------
	
	--------------------------------------------------------------------
	--	types defined in std, included with the compiler; not to be used
	--------------------------------------------------------------------
	-- type BIT is ( '0', '1' )
	
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
							'-', 	--	Don't care
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
	subtype UX01 is resolved std_ulogic range 'U' to '1'; -- ('U','X','0','1')
	
	--------------------------------------------------------------------
	--	overloaded logical operators
	--------------------------------------------------------------------
	function "and"	( l : std_ulogic; r : std_ulogic ) return UX01;
	function "nand"	( l : std_ulogic; r : std_ulogic ) return UX01;
	function "or"	( l : std_ulogic; r : std_ulogic ) return UX01;
	function "nor"	( l : std_ulogic; r : std_ulogic ) return UX01;
	function "xor"	( l : std_ulogic; r : std_ulogic ) return UX01;
	function "not"	( l : std_ulogic				 ) return UX01;
	
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
	--	edge detection
	--------------------------------------------------------------------
	function rising_edge	( signal s : std_ulogic ) return BOOLEAN;
	
end basic_logic;

