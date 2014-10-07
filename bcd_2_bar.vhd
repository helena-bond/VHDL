LIBRARY ieee;
USE ieee.std_logic_1164.all; 

ENTITY bcd_2_bar IS
	PORT (
		bcd : in std_logic_vector (3 downto 0);
		bar_graph : out std_logic_vector (8 downto 0)
	);
end bcd_2_bar;

-- a description of the converter using a selected signal assignment, all outputs 1s for the six invalid input codes
ARCHITECTURE selected_off OF bcd_2_bar IS 
BEGIN 
  WITH bcd SELECT
  	bar_graph <= "111111111" WHEN "0000",
  				 "011111111" WHEN "0001",
  				 "001111111" WHEN "0010",
  				 "000111111" WHEN "0011",
  				 "000011111" WHEN "0100",
  				 "000001111" WHEN "0101",
  				 "000000111" WHEN "0110",
  				 "000000011" WHEN "0111",
  				 "000000001" WHEN "1000",
  				 "000000000" WHEN "1001",
  				 "111111111" WHEN OTHERS;
END selected_off; 

-- a description of the converter using selected signal assignments, all outputs don’t care values for the six invalid input codes
ARCHITECTURE selected_dont OF bcd_2_bar IS 
BEGIN 
  WITH bcd SELECT
  	bar_graph <= "111111111" WHEN "0000",
  				 "011111111" WHEN "0001",
  				 "001111111" WHEN "0010",
  				 "000111111" WHEN "0011",
  				 "000011111" WHEN "0100",
  				 "000001111" WHEN "0101",
  				 "000000111" WHEN "0110",
  				 "000000011" WHEN "0111",
  				 "000000001" WHEN "1000",
  				 "000000000" WHEN "1001",
  				 "---------" WHEN OTHERS;
END selected_dont;

-- a description of the converter using a conditional signal assignment, outputs 1s for the six invalid input codes
ARCHITECTURE conditional_off OF bcd_2_bar IS 
BEGIN 
	bar_graph <= "111111111" WHEN bcd = "0000" ELSE
				 "011111111" WHEN bcd = "0001" ELSE
				 "001111111" WHEN bcd = "0010" ELSE
				 "000111111" WHEN bcd = "0011" ELSE
				 "000011111" WHEN bcd = "0100" ELSE
				 "000001111" WHEN bcd = "0101" ELSE
				 "000000111" WHEN bcd = "0110" ELSE
				 "000000011" WHEN bcd = "0111" ELSE
				 "000000001" WHEN bcd = "1000" ELSE
				 "000000000" WHEN bcd = "1001" ELSE
				 "111111111";
END conditional_off; 

-- a description of the converter using conditional signal assignments, outputs don’t care values for the six invalid input codes
ARCHITECTURE conditional_dont OF bcd_2_bar IS 
BEGIN 
	bar_graph <= "111111111" WHEN bcd = "0000" ELSE
				 "011111111" WHEN bcd = "0001" ELSE
				 "001111111" WHEN bcd = "0010" ELSE
				 "000111111" WHEN bcd = "0011" ELSE
				 "000011111" WHEN bcd = "0100" ELSE
				 "000001111" WHEN bcd = "0101" ELSE
				 "000000111" WHEN bcd = "0110" ELSE
				 "000000011" WHEN bcd = "0111" ELSE
				 "000000001" WHEN bcd = "1000" ELSE
				 "000000000" WHEN bcd = "1001" ELSE
				 "---------";
END conditional_dont; 