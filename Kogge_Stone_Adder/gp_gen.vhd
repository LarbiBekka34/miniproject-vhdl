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
-- File : gp_gen.vhd
-- Design : 64-bit Kogge-Stone adder
------------------------------------------------------
-- Description : a 1-bit g,p generator 
-------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY gp_gen IS
	PORT(
		x : IN std_logic;
		y : IN std_logic;
		g : OUT std_logic;
		p : OUT std_logic
	);
END gp_gen;

ARCHITECTURE arch OF gp_gen IS
BEGIN
	g <= x AND y;
	p <= x XOR y;
END arch;
