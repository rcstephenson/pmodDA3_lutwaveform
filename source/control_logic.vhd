library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_logic is 
    generic(N : integer := 16);
    port(
        clk : in std_logic;
         CS : out std_logic;
       dout : out std_logic; 
       LDAC : out std_logic;
        Din : in std_logic_vector(N-1 downto 0);
      state : out std_logic_vector(2 downto 0);
        rst : in std_logic --active low
    );
end control_logic;

architecture behv of control_logic is 
  signal s_out : std_logic_vector(2 downto 0);
   signal step : unsigned(7 downto 0);
begin 
  process (clk, rst, Din) begin 
    if (rst='1') then 
      s_out <= "101";
      step <= X"00";
    elsif (clk'event and clk='1') then
      if (step < X"13") then 
        step <= step + 1;
      else 
        step <= (others =>'0');
      end if;
      case step is 
        when X"00" => --inital state
          s_out <= "101";
        when X"01" =>  -- begin sending data
          s_out <= '0' & Din(15) & '1';
        when X"02" => 
          s_out <= '0' & Din(14) & '1' ; 
        when X"03" => 
          s_out <= '0' & Din(13) & '1';
        when X"04" => 
          s_out <= '0' & Din(12) & '1';
          when X"05" => 
          s_out <= '0' & Din(11) & '1';
        when X"06" => 
          s_out <= '0' & Din(10) & '1';
        when X"07" => 
          s_out <= '0' & Din(9) & '1';
        when X"08" => 
          s_out <= '0' & Din(8) & '1';
        when X"09" => 
          s_out <= '0' & Din(7) & '1';
        when X"0A" => 
          s_out <= '0' & Din(6) & '1';
        when X"0B" => 
          s_out <= '0' & Din(5) & '1';
        when X"0C" => 
          s_out <= '0' & Din(4) & '1';
        when X"0D" => 
          s_out <= '0' & Din(3) & '1';
        when X"0E" => 
          s_out <= '0' & Din(2) & '1';
        when X"0F" => 
          s_out <= '0' & Din(1) & '1';
        when X"10" => 
          s_out <= '0' & Din(0) & '1';
        when X"11" => --pull up CS and pulse LDAC
          s_out <= "101";
        when X"12" => --back to initial state
          s_out <= "100";
        when X"13" => --pull up CS and pulse LDAC
          s_out <= "101";
        when others =>
          s_out <= "101";
        end case;
    end if;
  end process;
  CS <= s_out(2);
  dout <= s_out(1);
  LDAC <= s_out(0);
  state <= s_out;  
end behv;