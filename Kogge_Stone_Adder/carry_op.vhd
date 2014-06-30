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
-- File : carry_op.vhd
-- Design : 64-bit Kogge-Stone adder
------------------------------------------------------
-- Description : a carry operator unit
-------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY carry_op IS
	PORT(
		g1 : IN std_logic;
		p1 : IN std_logic;
		g2 : IN std_logic;
		p2 : IN std_logic;
		go : OUT std_logic;
		po : OUT std_logic
	);
END carry_op;

ARCHITECTURE arch OF carry_op IS
BEGIN
	go <= g2 OR (g1 AND p2);
	po <= P2 AND p1;
END arch;	
