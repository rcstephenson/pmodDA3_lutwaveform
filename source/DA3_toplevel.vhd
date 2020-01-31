-- Top Level Wrapper for DA3 reg source
-- Ryan Stephenson 31 Jan 2019
library ieee;
use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;

entity DA3_toplevel is 
  generic( N : integer := 7; --array length = 2**N
             M : integer := 16); --data width
    port(
        clk : in std_logic;
        rst : in std_logic;
        sclk : out std_logic;
        cs : out std_logic;
        dout : out std_logic;
        LDAC : out std_logic
    );
end DA3_toplevel;


architecture wrapper of DA3_toplevel is 
    signal state : std_logic_vector(2 downto 0);
     signal ADDR : std_logic_vector(N-1 downto 0);
      signal Din : std_logic_vector(M-1 downto 0);
   
    component ROM 
    generic( N : integer := 7;
            M : integer := 16); 
     port(clk : in std_logic;
         ADDR : in std_logic_vector(N-1 downto 0);
           en : in std_logic; 
         Dout : out std_logic_vector(M-1 downto 0)); END COMPONENT;
    
    component control_logic
    generic(N : integer := 16);
     port(clk : in std_logic;
           CS : out std_logic;
         dout : out std_logic; 
         LDAC : out std_logic;
          Din : in std_logic_vector(N-1 downto 0);
        state : out std_logic_vector(2 downto 0);
          rst : in std_logic); END COMPONENT;
         
        
    component addr_logic
    generic (N : integer := 7); 
     port( clk : in std_logic;
           inp : in std_logic_vector(2 downto 0);
          ADDR : out std_logic_vector(N-1 downto 0);
           rst : in std_logic); end COMPONENT;
begin
    A: ROM port map(
        clk => clk,
        addr => addr,
        en => rst,
        Dout => Din);

    B:  control_logic port map(
        clk => clk, 
        CS => CS, 
        dout => dout, 
        LDAC => LDAC, 
        Din => Din, 
        state => state, 
        rst => rst);

    C: addr_logic port map(
        clk => clk,
        inp => state,
        addr => addr,
        rst => rst); 
end wrapper;