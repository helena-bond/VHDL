LIBRARY ieee;
USE ieee.std_logic_1164.all; 
USE ieee.numeric_std.all;

ENTITY bcd_2_bar_testbench IS
END bcd_2_bar_testbench; 

architecture tb of bcd_2_bar_testbench IS
  SIGNAL bcd_test: std_logic_vector (3 downto 0);
  SIGNAL bar_graph_test: std_logic_vector (8 downto 0);
  SIGNAL bar_graph_check: std_logic_vector (8 downto 0);
  SIGNAL check: STD_LOGIC;
BEGIN
  UUT: entity work.bcd_2_bar(selected_dont)
    PORT MAP (
      bcd => bcd_test,
      bar_graph => bar_graph_test
    );
  
  Testing: PROCESS
    BEGIN
      bar_graph_check <= "111111111";
      bcd_test <= "0000";
      for i in 0 to 15 loop 
        bcd_test <= std_logic_vector(to_unsigned(i, 4));
        if bar_graph_test = bar_graph_check then
          check <= '1';
        else
          if bar_graph_check = "---------" AND bar_graph_test = "---------" then
            check <= '1';
          else 
            check <= '0';
          end if;
        end if;
        wait for 10 ns;
        if i < 9 then
          bar_graph_check(8-i) <= '0';
        else
          bar_graph_check <= "---------";
        end if;
      end loop;
    END PROCESS;
END tb;

