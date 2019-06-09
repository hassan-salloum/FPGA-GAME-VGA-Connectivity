library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
----------------------------------------------------------------------------------------------------
entity VGA_sync is Port ( 
Clk  : in  STD_LOGIC;
hsync : out  STD_LOGIC;
vsync : out  STD_LOGIC;
Red   : out  STD_LOGIC_VECTOR (2 downto 0);
Green : out  STD_LOGIC_VECTOR (2 downto 0);
Blue  : out  STD_LOGIC_VECTOR (2 downto 1);

x: in integer;
yb: in integer;

-- ya1 ya2 ya3 ya4 not used in the program yet, dont wory about it (for future perpose)
ya1:in integer;
ya2:in integer;
ya3:in integer;
ya4:in integer;

ya5:in integer
);
end VGA_sync;
----------------------------------------------------------------------------------------------------
architecture Behavioral of VGA_sync is	
begin
---------------------------------------------------------------------------------------------------			       
process(Clk)
	variable ligne: integer:=0;
	variable colonne: integer:=0;
	variable drawBorderH : std_logic;
	variable drawBorderV : std_logic;
	variable drawCur : std_logic;
	
	variable drawBall : std_logic;
	variable AltenLigne1 : std_logic;
	variable AltenLigne2 : std_logic;
	variable AltenLigne3 : std_logic;
	variable AltenLigne4 : std_logic;
	variable AltenLigne5 : std_logic;
begin
---------------------------------------------------------------------------------------------------
if rising_edge (Clk) then

if (ligne>135 and ligne<155) and ((colonne>264 and colonne<324) or(colonne>344 and colonne<364) or 
(colonne>404 and colonne<464)or(colonne>484 and colonne<544) or (colonne>564 and colonne<604) or
(colonne>684 and colonne<704))then
AltenLigne1 :='1';
else
AltenLigne1 :='0';
end if;

if (ligne>155 and ligne<175) and ((colonne>264 and colonne<284) or(colonne>304 and colonne<324) or 
(colonne>344 and colonne<364)or(colonne>424 and colonne<444) or (colonne>484 and colonne<504) or
(colonne>564 and colonne<584)or(colonne>604 and colonne<624) or (colonne>684 and colonne<704))then
AltenLigne2 :='1';
else
AltenLigne2 :='0';
end if;

if (ligne>175 and ligne<195) and ((colonne>264 and colonne<324) or(colonne>344 and colonne<364)or
(colonne>424 and colonne<444) or (colonne>484 and colonne<544) or
(colonne>564 and colonne<584)or(colonne>624 and colonne<644) or (colonne>684 and colonne<704))then
AltenLigne3 :='1';
else
AltenLigne3 :='0';
end if;

if (ligne>195 and ligne<215) and ((colonne>264 and colonne<284) or(colonne>304 and colonne<324)or
(colonne>344 and colonne<364)or (colonne>424 and colonne<444) or (colonne>484 and colonne<504) or
(colonne>564 and colonne<584)or(colonne>644 and colonne<664) or (colonne>684 and colonne<704))then
AltenLigne4 :='1';
else
AltenLigne4 :='0';
end if;

if (ligne>ya5 - 10 and ligne<ya5+10) and ((colonne>264 and colonne<284) or(colonne>304 and colonne<324)or
(colonne>344 and colonne<404)or (colonne>424 and colonne<444) or (colonne>484 and colonne<544) or
(colonne>564 and colonne<584)or (colonne>664 and colonne<704))then
AltenLigne5 :='1';
else
AltenLigne5 :='0';
end if;





if (ligne>35 and ligne<515) and ( (colonne>144 and colonne<164) or (colonne>764 and colonne<784) )then
drawBorderV :='1';
else
drawBorderV :='0';
end if;

if (colonne>144) and (colonne<784) and (  (ligne>35 and ligne<55) or (ligne>495 and ligne<515) )  then
drawBorderH :='1';
else
drawBorderH :='0';
end if;

if (colonne>x-30) and (colonne<x+30) and (ligne>435 and ligne<445) then
drawCur:='1';
else
drawCur:='0';
end if;


if (colonne>x-4 and colonne<x+4) and (ligne>yb-4 and ligne<yb+5) then
drawBall:='1';
else
drawBall:='0';
end if;
---------------------------------------------------------------------------------------------------------
if (colonne<144) or (ligne<35) then
Red<=(others=>'0');
Green<=(others=>'0');
Blue<=(others=>'0');

elsif DrawBorderH ='1' or DrawBorderV ='1' then
Red<=(others=>'0');
Green<=(others=>'0');
Blue<=(others=>'0');

elsif DrawCur='1' then
Red<="110";
Green<=(others=>'0');
Blue<=(others=>'0');


elsif DrawBall='1' then
Red<=(others=>'0');
Green<=(others=>'0');
Blue<="10";

elsif AltenLigne5 ='1' or AltenLigne4 ='1' or AltenLigne3 ='1' or AltenLigne2 ='1' or AltenLigne1 ='1' then
Red<=(others=>'0');
Green<=(others=>'0');
Blue<=(others=>'0');

else
Red<="111";
Green<="111";
Blue<="11";
end if;
---------------------------------------------------------------------------------------------------------
if colonne = 784 then
colonne := 0;
ligne := ligne + 1;
	if ligne = 515 then
	ligne := 0;
	end if;
	else
	colonne:=colonne +1;
end if;	
						
if colonne<96 then
hsync <= '0';
else
hsync <= '1';
end if;
                                    									
if ligne<2 then
vsync <= '0';
else
vsync <= '1';
end if;
---------------------------------------------------------------------------------------------------
end if;
---------------------------------------------------------------------------------------------------                  
end process;                                      									
---------------------------------------------------------------------------------------------------
end Behavioral;

