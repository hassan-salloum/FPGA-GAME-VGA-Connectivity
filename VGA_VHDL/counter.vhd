library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

---------------------------------------------------------------------------------------------------
entity counter is 
generic (n:positive:=13);	
port( 
clk: in std_logic; 
sortie:out std_logic_vector (n-1 downto 0));
end counter;
---------------------------------------------------------------------------------------------------
architecture Behavioral of counter is
begin
---------------------------------------------------------------------------------------------------

process (clk)is
variable compteur: std_logic_vector (n-1 downto 0):=(others=>'0');
variable carry:std_logic_vector (n downto 0);
begin
---------------------------------------a------------------------------------------------------------

if clk'event and clk='1' then
carry(0):='1';
for i in 0 to n-1 loop
carry(i+1) := compteur(i) and carry(i);
compteur(i):= compteur(i) xor carry(i);
end loop;
end if;
---------------------------------------------------------------------------------------------------

sortie<=compteur;
---------------------------------------------------------------------------------------------------

end process;
----------------------------------------------------------------------------------------------------

end Behavioral ;