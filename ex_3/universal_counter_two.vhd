library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity universal_counter_two is
  port(
    downup :in std_logic;
    reset  :in std_logic;
    enable :in std_logic;
    load   :in std_logic;
    data   :in std_logic_vector(3 downto 0);
    clock  :in std_logic;
    over  :out std_logic;
    count :out std_logic_vector(3 downto 0)
  );
end universal_counter_two;

architecture two_processes of universal_counter_two is
  signal operation_mode: std_logic_vector(1 downto 0);
begin
  logic: process(enable, load, downup)
  begin
    if (enable = '0') then
      operation_mode <= "00";
    elsif (enable = '1' and load = '1') then
      operation_mode <= "01";
    elsif (enable = '1' and downup = '1') then
      operation_mode <= "10";
    elsif (enable = '1' and downup = '0') then
      operation_mode <= "11";
    end if;
  end process;

  registers: process(clock, reset)
    variable counter_state: std_logic_vector(3 downto 0);
    variable overflow_flag: std_logic;
  begin
    -- asynchronous reset
    if (reset = '1') then
      if (downup = '0') then
        counter_state := "0000";
      else
        counter_state := "1111";
      end if;
      overflow_flag := '0';
    end if;

    if (clock'event and clock = '1') then
      -- enable & up
      if (operation_mode = "11") then
        if (counter_state = "1111") then
          counter_state := "0000";
          overflow_flag := '1';
        else
          counter_state := std_logic_vector(unsigned(counter_state) + 1);
        end if;
      -- enable & down
      elsif (operation_mode = "10") then
        if counter_state = "0000" then
          counter_state := "1111";
          overflow_flag := '1';
        else
          counter_state := std_logic_vector(unsigned(counter_state) - 1);
        end if;
      -- enable & load
      elsif (operation_mode = "01") then
        counter_state := data;
        overflow_flag := '0';
      else
        -- do nothing
        -- since enable = 0
      end if;

      over  <= overflow_flag;
      count <= counter_state;
    end if;
  end process;
end two_processes;
