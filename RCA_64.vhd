-------------------------------------------------------
--Copyright 2014 Larbi Bekka, Walid Belhadj, Oussama Hemchi
-------------------------------------------------------

-------------------------------------------------------
--This file is part of 64-bit Kogge-Stone adder.

    --64-bit Kogge-Stone adder is free hardware design: you can redistribute it and/or modify
    --it under the terms of the GNU General Public License as published by
    --the Free Software Foundation, either version 3 of the License, or
    --(at your option) any later version.

    --64-bit Kogge-Stone adder is distributed in the hope that it will be useful,
    --but WITHOUT ANY WARRANTY; without even the implied warranty of
    --MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    --GNU General Public License for more details.

    --You should have received a copy of the GNU General Public License
    --along with 64-bit Kogge-Stone adder.  If not, see <http://www.gnu.org/licenses/>.
--------------------------------------------------------

-------------------------------------------------------
-- Project : Computer arithmetic, fast adders (3rd year mini project)
-- Author : Larbi Bekka, Walid Belhadj, Oussama Hemchi 
-- Date : 10-05-2014
-- File : RCA_64.vhd
-- Design : 64-bit Ripple-Carry Adder
------------------------------------------------------
-- Description : a 64-bit Ripple-Carry Adder
-------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY RCA_64 IS
	PORT(x        : IN std_logic_vector(63 downto 0);
	     y        : IN std_logic_vector(63 downto 0);
	     c_in     : IN std_logic;
       	     sum      : OUT std_logic_vector(63 downto 0);
             c_o      : OUT std_logic;
END RCA_64;

ARCHITECTURE arch OF RCA_64 IS
	SIGNAL in_c : std_logic_vector(64 downto 0);
BEGIN
	inconc_c(0) <= c_in;
	
	for_gen:
		FOR i in 0 to 63 GENERATE
			sum(i) <= x(i) XOR y(i) XOR inconc_c(i);
			in_c(i+1) <= (x(i) AND y(i)) OR (inconc_c(i) AND x(i)) OR (inconc_c(i) AND y(i));
		END GENERATE;
	
	
	c_o <= in_c(64);
	
END arch;		  
	
