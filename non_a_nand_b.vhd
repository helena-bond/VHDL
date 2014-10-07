LIBRARY ieee;
USE ieee.std_logic_1164.all; 

ENTITY non_a_nand_b IS
PORT( 
  i1 : IN STD_LOGIC; 
  i2 : IN STD_LOGIC;
  y : OUT STD_LOGIC
); 
END non_a_nand_b; 

ARCHITECTURE dataflow OF non_a_nand_b IS 
  SIGNAL i3: STD_LOGIC;
BEGIN 
  i3 <= NOT i1;
  y <= i3 NAND i2;
END dataflow; 
