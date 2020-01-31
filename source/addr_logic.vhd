-- simple generic vhdl template
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity addr_logic is 
generic (N : integer := 7); --array length
    port(
         clk : in std_logic;
         inp : in std_logic_vector(2 downto 0);
        ADDR : out std_logic_vector(N-1 downto 0);
         rst : in std_logic
    );
end addr_logic;

architecture behv of addr_logic is 
    signal val : unsigned(N-1 downto 0);
begin 
    process (clk,rst,inp)
    begin
        if(rst='1') then 
            val <= (others => '0');
        elsif (clk'event and clk='1') then 
            if (inp="100") then 
                if (val<82) then
                    val <= val + 1;
                else 
                     val <= (others => '0');
                end if;
            else 
                val <= val;
            end if;
         end if;
    end process;
    ADDR <= std_logic_vector(val);
end behv;