LIBRARY ieee;
USE ieee.std_logic_1164.all; 
USE ieee.numeric_std.all;

ENTITY tally_testbench IS
END tally_testbench; 

architecture tb of tally_testbench IS
  SIGNAL scoresA_test: std_logic_vector (2 downto 0);
  SIGNAL scoresB_test: std_logic_vector (2 downto 0);
  SIGNAL A: integer;
  SIGNAL B: integer;
  SIGNAL winner_expected: std_logic_vector (1 downto 0);
  SIGNAL winner_test: std_logic_vector (1 downto 0);
  --SIGNAL bar_graph_check: std_logic_vector (8 downto 0);
  SIGNAL check: STD_LOGIC;


BEGIN
  UUT: entity work.tally(loopy)
    PORT MAP (
      scoresA => scoresA_test,
      scoresB => scoresB_test,
      winner => winner_test
    );
  
  Testing: PROCESS
    BEGIN
		for i in 0 to 7 loop 
			A <= 0;
    		B <= 0;
			scoresA_test <= std_logic_vector(to_unsigned(i, 3));
			for j in 0 to 7 loop
				scoresB_test <= std_logic_vector(to_unsigned(j, 3));
				for i1 in 0 to 2 loop
					if (scoresA_test(i1) = '1') then
						A <= A + 1;
					end if;
					if (scoresB_test(i1) = '1') then
						B <= B + 1;
					end if;
				end loop;
				if ((A = 0) AND (B = 0)) then
					winner_expected <= "00";
				else
					if (A > B) then
						winner_expected <= "01";
					else
						if (B > A) then
							winner_expected <= "10";
						else
							winner_expected <= "11";
						end if;
					end if;
				end if;
				if (winner_test = winner_expected) then
					check <= '1';
				else
					check <= '0';
				end if;

				--if ((A = 0) AND (B = 0) AND (winner_test = "00")) then
				--	check <= '1';
				--else
				--	if ((A > B) AND (winner_test = "01")) then
				--		check <= '1';
				--	else
				--		if ((A < B) AND (winner_test = "10")) then
				--			check <= '1';
				--		else
				--			if ((A = B) AND (winner_test = "11")) then
				--				check <= '1';
				--			else
				--				check <= '0';
				--			end if;
				--		end if;
				--	end if;
				--end if;
				wait for 10 ns;
			end loop;
		end loop;
    END PROCESS;
END tb;


