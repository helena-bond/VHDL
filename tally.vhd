LIBRARY ieee;
USE ieee.std_logic_1164.all; 
USE ieee.numeric_std.all;

entity tally is
	port (scoresA, scoresB : in std_logic_vector (2 downto 0);
	winner : out std_logic_vector (1 downto 0));
end entity;

ARCHITECTURE loopy OF tally IS
	signal A, B: integer;
BEGIN
	process (scoresA, scoresB)
	begin
		for I in 0 to 2 loop
			if (scoresA(I) = '1') then
				A <= A + 1;
			end if;
			if (scoresB(I) = '1') then
				B <= B + 1;
			end if;
		end loop;

	end process;
	winner <= "00" WHEN ((A = 0) AND (B = 0)) ELSE
			  "01" WHEN A > B ELSE
			  "10" WHEN B > A ELSE
			  "11";
END loopy;