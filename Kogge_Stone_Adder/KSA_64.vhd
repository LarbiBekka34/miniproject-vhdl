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
-- File : KSA_64.vhd
-- Design : 64-bit Kogge-Stone adder
------------------------------------------------------
-- Description : a 64-bit Kogge-Stone adder
-------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.KSA_pkg.all;

ENTITY KSA_64 IS
	PORT(
		x     : IN std_logic_vector(63 downto 0);
		y     : IN std_logic_vector(63 downto 0);
		c_in  : IN std_logic;
		sum   : OUT std_logic_vector(63 downto 0);
		c_out : OUT std_logic
	);
END KSA_64;

ARCHITECTURE arch OF KSA_64 IS

	--internal individual g,p signals--
	SIGNAL g_in : std_logic_vector(63 downto 0);
	SIGNAL p_in : std_logic_vector(63 downto 0);
	
	--output g,p signals of each KS stage--
		--stage 01
		SIGNAL g_1 : std_logic_vector(63 downto 0);
		SIGNAL p_1 : std_logic_vector(63 downto 0);
		--stage 02
		SIGNAL g_2 : std_logic_vector(63 downto 0);
		SIGNAL p_2 : std_logic_vector(63 downto 0);
		--stage 03
		SIGNAL g_3 : std_logic_vector(63 downto 0);
		SIGNAL p_3 : std_logic_vector(63 downto 0);
		--stage 04
		SIGNAL g_4 : std_logic_vector(63 downto 0);
		SIGNAL p_4 : std_logic_vector(63 downto 0);
		--stage 05
		SIGNAL g_5 : std_logic_vector(63 downto 0);
		SIGNAL p_5 : std_logic_vector(63 downto 0);
		--stage 06
		SIGNAL g_6 : std_logic_vector(63 downto 0);
		SIGNAL p_6 : std_logic_vector(63 downto 0);
	
	--internal carries--
	SIGNAL c : std_logic_vector(63 downto 0);
	--SIGNAL p_block : std_logic_vector(63 downto 0);
	
	
BEGIN
	--generating stage00 g,p signals--
	stg00:
			FOR i IN 0 TO 63 GENERATE
				pm: gp_gen PORT MAP (x => x(i) , y => y(i) , g => g_in(i) , p => p_in(i) );
			END GENERATE;

			
	--stage01 carry operations--
	g_1(0) <= g_in(0);
	p_1(0) <= p_in(0);
	stg01:
			FOR i IN 0 TO 62 GENERATE
				pm: carry_op PORT MAP (g1 => g_in(i) , p1 => p_in(i) , g2 => g_in(i+1) , p2 => p_in(i+1) , go => g_1(i+1) , po => p_1(i+1) );
			END GENERATE;	
			
	--stage02 carry operations--
	buffa1:
			FOR i IN 0 TO 1 GENERATE
				g_2(i) <= g_1(i);
				p_2(i) <= p_1(i);
			END GENERATE;
	stg02:		
			FOR i IN 0 TO 61 GENERATE
				pm: carry_op PORT MAP (g1 => g_1(i) , p1 => p_1(i) , g2 => g_1(i+2) , p2 => p_1(i+2) , go => g_2(i+2) , po => p_2(i+2) );
			END GENERATE;
			
	--stage03 carry operations--
	buffa2:
			FOR i IN 0 TO 3 GENERATE
				g_3(i) <= g_2(i);
				p_3(i) <= p_2(i);
			END GENERATE;
	stg03:		
			FOR i IN 0 TO 59 GENERATE
				pm: carry_op PORT MAP (g1 => g_2(i) , p1 => p_2(i) , g2 => g_2(i+4) , p2 => p_2(i+4) , go => g_3(i+4) , po => p_3(i+4) );
			END GENERATE;

	--stage04 carry operations--
	buffa3:
			FOR i IN 0 TO 7 GENERATE
				g_4(i) <= g_3(i);
				p_4(i) <= p_3(i);
			END GENERATE;
	stg04:		
			FOR i IN 0 TO 55 GENERATE
				pm: carry_op PORT MAP (g1 => g_3(i) , p1 => p_3(i) , g2 => g_3(i+8) , p2 => p_3(i+8) , go => g_4(i+8) , po => p_4(i+8) );
			END GENERATE;
			
	--stage05 carry operations--
	buffa4:
			FOR i IN 0 TO 15 GENERATE
				g_5(i) <= g_4(i);
				p_5(i) <= p_4(i);
			END GENERATE;
	stg05:		
			FOR i IN 0 TO 47 GENERATE
				pm: carry_op PORT MAP (g1 => g_4(i) , p1 => p_4(i) , g2 => g_4(i+16) , p2 => p_4(i+16) , go => g_5(i+16) , po => p_5(i+16) );
			END GENERATE;
			
	--stage06 carry operations--
	buffa5:
			FOR i IN 0 TO 31 GENERATE
				g_6(i) <= g_5(i);
				p_6(i) <= p_5(i);
			END GENERATE;
	stg06:		
			FOR i IN 0 TO 31 GENERATE
				pm: carry_op PORT MAP (g1 => g_5(i) , p1 => p_5(i) , g2 => g_5(i+32) , p2 => p_5(i+32) , go => g_6(i+32) , po => p_6(i+32) );
			END GENERATE;
			
	c_gen:
			FOR i IN 0 TO 63 GENERATE
				c(i) <= g_6(i) OR (c_in AND p_6(i));
			END GENERATE;
	c_out  <= c(63);
	sum(0) <= c_in XOR p_in(0);
	addin:
			FOR i IN 1 TO 63 GENERATE
				sum(i) <= c(i-1) XOR p_in(i);
			END GENERATE;
END arch;	
