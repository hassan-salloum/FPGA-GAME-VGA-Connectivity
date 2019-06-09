library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;
use work.all;
---------------------------------------------------------------------------------------------------
entity topmodule is port (
CLOCK_12 : in  STD_LOGIC;
hsync : out  STD_LOGIC;
vsync : out  STD_LOGIC;
Red : out  STD_LOGIC_VECTOR (2 downto 0);
Green : out  STD_LOGIC_VECTOR (2 downto 0);
Blue : out  STD_LOGIC_VECTOR (2 downto 1);
KEY : in STD_LOGIC_VECTOR (2 downto 0)
);
end topmodule;
---------------------------------------------------------------------------------------------------
architecture Behavioral of topmodule is

signal CLOCK_25:STD_LOGIC;

signal count:std_logic_vector (20 downto 0):=(others=>'0');

signal x:integer:=464;
signal yb:integer:=395;

signal buttonPushCounter:integer:= 0;   -- counter for the number of button presses of key[0]
signal lastButtonState:STD_LOGIC:= '1'; -- previous state of the button key[0]

-- ya1 ya2 ya3 ya4 not used in the program yet, dont wory about it (for future perpose)
signal ya1:integer:=145;
signal ya2:integer:=165;
signal ya3:integer:=185;
signal ya4:integer:=205;

signal ya5:integer:=225;


--this component get 12mhz as input(CLKIN_IN=CLOCK_12) and give me 25mhz as output (CLOCK_OUT=CLOCK_25)
--CLOCK_12 predifined in the  topmodule.ucf
component IN_CLOCK_OUT port(
CLKIN_IN         : in     std_logic; 
CLKFX_OUT        : out    std_logic);
end component;


--this component get 25mhz as input(clk=CLOCK_25) and give me an output (sortie=count)
component counter 
generic (n:positive:=21);	
port(
clk          : in     std_logic; 
sortie		 : out std_logic_vector (20 downto 0)); 
end component;


--this component get 25mhz as input(clk=CLOCK_25) and give me an output (sortie=count)
component VGA_sync port(
Clk  : in  STD_LOGIC;
hsync : out  STD_LOGIC;
vsync : out  STD_LOGIC;
Red   : out  STD_LOGIC_VECTOR (2 downto 0);
Green : out  STD_LOGIC_VECTOR (2 downto 0);
Blue  : out  STD_LOGIC_VECTOR (2 downto 1);
x: in integer;
yb: in integer;

-- ya1 ya2 ya3 ya4 ya5 not used in the program yet, dont wory about it (for future perpose)
ya1:in integer;
ya2:in integer;
ya3:in integer;
ya4:in integer;
ya5:in integer);

end component;

begin
-------------------------------------------------------------------------------------------------
U1:IN_CLOCK_OUT port map (CLOCK_12, CLOCK_25);
U2: counter generic map(21) port map (CLOCK_25,count);
U3: VGA_sync  port map (count(0),hsync,vsync,Red,Green,Blue,x,yb,ya1,ya2,ya3,ya4,ya5);
---------------------------------------------------------------------------------------------------
process (count(17))

begin
	if count(17)'event and count(17)='1' then
	
		if (KEY (0) /= lastButtonState)  then
				
				if KEY(0) = '0' then
				buttonPushCounter<=buttonPushCounter+1;								
				else 
				buttonPushCounter<=buttonPushCounter-1;
				end if;
			
			end if;				
			lastButtonState<=KEY (0);
			
		if KEY (2)='0' then
			if x>734 then
			x<=734;
			else
			x<=x+1;
			end if;
						
		elsif KEY (1)='0' then
			if x<194 then
			x<=194;
			else
			x<=x-1;
			end if;
					
		end if;
		
		
	end if;

end process;
--------------------------------------------------------------------------------------------------------
process (count(12), buttonPushCounter)

begin

if count(12)'event and count(12)='1' then


			if (buttonPushCounter = 0) then 
			yb<=395;
			else 
			while (yb >55) loop
			yb<=yb-1;		
			end loop; 
			end if;
		
			

end if;	
		
end process;
-------------------------------------------------------------------------------------------------------------
end Behavioral;

