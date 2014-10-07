LIBRARY ieee;
USE ieee.std_logic_1164.all; 

ENTITY multiplexer_2_1_testbench IS
END multiplexer_2_1_testbench; 

architecture tb of multiplexer_2_1_testbench IS
SIGNAL test_vector: STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL test_result: STD_LOGIC;
BEGIN
  UUT: entity work.multiplexer_2_1(structural)
    PORT MAP (
      a => test_vector(2),
      b => test_vector(1),
      s => test_vector(0),
      o => test_result
    );
  
  Testing: PROCESS
    BEGIN
      test_vector <= "000";
      WAIT FOR 10 ns;
      test_vector <= "001";
      WAIT FOR 10 ns;
      test_vector <= "010";
      WAIT FOR 10 ns;
      test_vector <= "011";
      WAIT FOR 10 ns;
      test_vector <= "100";
      WAIT FOR 10 ns;
      test_vector <= "101";
      WAIT FOR 10 ns;
      test_vector <= "110";
      WAIT FOR 10 ns;
      test_vector <= "111";
      WAIT FOR 10 ns;
    END PROCESS;
END tb;
