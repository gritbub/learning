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

package basic_logic is
	
	--------------------------------------------------------------------
	--	logic state system (unresolved)
	--------------------------------------------------------------------
	type std_ulogic is (	'U',	--	Uninitialized
							'X',	--	Forcing	Unknown
							'0',	--	Forcing	0
							'1',	--	Forcing	1
							'Z',	--	High Impedance
							'W',	--	Weak	Unknown
							'L',	--	Weak	0
							'H',	--	Weak	1
							'-',	--	Don't care
						);
	
	--------------------------------------------------------------------
	--	*** industry standard logic type ***
	--------------------------------------------------------------------
	subtype	std_logic is resolved std_ulogic;
	
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
--   v4.200 | 01/02/92  |
-- --------------------------------------------------------------------