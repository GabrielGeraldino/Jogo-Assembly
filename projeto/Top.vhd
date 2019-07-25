library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TOP is
Port ( CLK : in STD_LOGIC;
RST : in STD_LOGIC;
red_out : out std_logic;
green_out : out std_logic;
blue_out : out std_logic;
hs_out : out std_logic;
vs_out : out std_logic;
baixo : in std_logic;
cima : in std_logic;
esquerda : in std_logic;
direita : in std_logic


);
end TOP;
architecture Behavioral of TOP is


-- CONTROLE DE CLOCK E TELA

signal clk50, clk25 : STD_LOGIC;
signal horizontal_counter : std_logic_vector (9 downto 0);
signal vertical_counter : std_logic_vector (9 downto 0);
signal a : integer range 0 to 770;
signal a2 : integer range 0 to 770;
signal a3 : integer range 0 to 770;
signal m : integer range 0 to 770;
signal v : integer range 0 to 770;
signal v2 : integer range 0 to 770;
signal b : integer range 0 to 520; 
signal d : integer range 0 to 770; 
signal c : integer range 0 to 520; 

begin


process (clk, rst)

begin
	if RST = '1' then
		
	elsif CLK'EVENT and CLK = '1' then
		-- CLOCK PARA CONTROLE DA TELA
		if (clk50 = '0') then
			clk50 <= '1';
		else
			clk50 <= '0';
		end if;
	
		
	end if;
end process;

-- DIMINUI CLOCK PARA EXIBIÇÃO DA TELA
process (clk50)
begin
	if clk50'event and clk50='1' then
		if (clk25 = '0') then
			clk25 <= '1';
		else
			clk25 <= '0';
		end if;
	end if;
end process;


-- CLOCCK BIXO
process (clk)
variable contx: integer range 0 to 100000001; --1s
begin
	if RST = '1' then
     b<=0; 
	elsif baixo = '1' then
 if clk'event and clk='1' then
		contx :=contx +1;
		if contx = 800000 then
			contx :=0;
			b<= b+1;
			end if;
		end if;
	end if;
end process;

-- CLOCK CARRINHO AZUL
process (clk)
variable cont: integer range 0 to 100000001; --1s
begin
	if RST = '1' then
     a<=0;
 elsif clk'event and clk='1' then
		cont :=cont +1;
		if cont = 500000 then --0,5s
		  cont :=0;
		  a<= a+1;
		end if;
	end if;
end process;

-- CLOCK CARRINHO AMARELO
process (clk)
variable cont1: integer range 0 to 100000001; --1s
begin
	if RST = '1' then
     m<=0;
 elsif clk'event and clk='1' then
		cont1 :=cont1 +1;
		if cont1 = 400000 then --0,5s
		  cont1 :=0;
		  m<= m+1;
		end if;
	end if;
end process;

-- CLOCK CARRINHO VERMELHO 1
process (clk)
variable cont2: integer range 0 to 100000001; --1s
begin
	if RST = '1' then
     v<=0;
 elsif clk'event and clk='1' then
		cont2 :=cont2 +1;
		if cont2 = 300000 then --0,5s
		  cont2 :=0;
		  v<= v+1;
		end if;
	end if;
end process;

-- CLOCK CARRINHO VERMELHO 2
process (clk)
variable cont3: integer range 0 to 100000001; --1s
begin
	if RST = '1' then
     v2<=0;
 elsif clk'event and clk='1' then
		cont3 :=cont3 +1;
		if cont3 = 250000 then --0,5s
		  cont3 :=0;
		  v2<= v2+1;
		end if;
	end if;
end process;

-- CLOCK CARRINHO AZUL 2
process (clk)
variable cont4: integer range 0 to 100000001; --1s
begin
	if RST = '1' then
     a2<=0;
 elsif clk'event and clk='1' then
		cont4 :=cont4 +1;
		if cont4 = 450000 then --0,5s
		  cont4 :=0;
		  a2<= a2+1;
		end if;
	end if;
end process;

-- CLOCK CARRINHO AZUL 3
process (clk)
variable cont5: integer range 0 to 100000001; --1s
begin
	if RST = '1' then
     a3<=0;
 elsif clk'event and clk='1' then
		cont5 :=cont5 +1;
		if cont5 = 420000 then --0,5s
		  cont5 :=0;
		  a3<= a3+1;
		end if;
	end if;
end process;


-- CONTROLE DA EXIBIÇÃO NA TELA
process (clk25)
variable printa: integer range 0 to 10;
variable flag : integer range 0 to 1;
variable flaga1 : integer range 0 to 1;
variable flaga2 : integer range 0 to 1;
variable flaga3 : integer range 0 to 1;
variable flaga4 : integer range 0 to 1;
variable flaga5 : integer range 0 to 1;
variable flaga6 : integer range 0 to 1;
variable flaga7 : integer range 0 to 1;
variable flaga8 : integer range 0 to 1;
variable flaga9 : integer range 0 to 1;
begin
 

	if clk25'event and clk25 = '1' then
	-- TAMANHO DO JOGO: 400x400 --> 50 PARA CADA BIT DA RAM
		if (horizontal_counter >= "0001111000" ) -- 140
		and (horizontal_counter < "1100001100" ) -- 780
		and (vertical_counter >= "0000101000" ) -- 40
		and (vertical_counter < "1000001000" ) -- 520
		then 
			printa := 4;
-- MOSTRANDO OS OBSTÁCULOS (CADA IF DO VERTICAL_COUNTER REPRESENTA
--UMA LINHA DA TELA, CADA IF INTERNO, DO HORIZONTAL_COUNTER, REPRESENTA UMA COLUNA
--DESTA LINHA)	


		--pinta de branco "pista"
		if vertical_counter >=90 AND vertical_counter <=470  then
			if horizontal_counter >= 140 AND horizontal_counter <= 780 then
				printa := 0;
			end if;	
		end if;
		    
		--carrinho azul 1 
		if vertical_counter >=100 AND vertical_counter <=120 then
			if horizontal_counter >= 140+(a*1) AND horizontal_counter <= 160+(a*1) then
				printa := 2;
			end if;	
		end if;
		
		if a>= 315 and a <= 325 then
			flaga1 := 1;
			else 
			flaga1 := 0; 
		end if;
		
		--carinho marelo 1
		if vertical_counter >=130 AND vertical_counter <=150  then
			if horizontal_counter >= 760-(m*1) AND horizontal_counter <= 780-(m*1) then
				printa := 3;
			end if;	
		end if;
		
		if m>= 315 and m <= 325 then
			flaga2 := 1;
			else 
			flaga2 := 0; 
		end if;
		
			--carinho vermelho 1
		if vertical_counter >=160 AND vertical_counter <=180  then
			if horizontal_counter >= 140+(v*1) AND horizontal_counter <= 160+(v*1) then
				printa := 1;
			end if;	
		end if;
		
		if a>= 315 and a <= 325 then
			flaga3 := 1;
			else 
			flaga3 := 0; 
		end if;
		
		--carriho vermelho 2
		if vertical_counter >=200 AND vertical_counter <=220  then
			if horizontal_counter >= 760-(v*1) AND horizontal_counter <= 780-(v*1) then
				printa := 1;
			end if;	
		end if;
		
		if a>= 315 and a <= 325 then
			flaga4 := 1;
			else 
			flaga4 := 0; 
		end if;
		
		-- carrinho marelo 2
		if vertical_counter >=240 AND vertical_counter <=260  then
			if horizontal_counter >= 140+(m*1) AND horizontal_counter <= 160+(m*1) then
				printa := 3;
			end if;	
		end if;
		
		if a>= 315 and a <= 325 then
			flaga5 := 1;
			else 
			flaga5 := 0; 
		end if;
		
		--carrinho vermelho 3
		if vertical_counter >=280 AND vertical_counter <=300  then
			if horizontal_counter >= 760-(v2*1) AND horizontal_counter <= 780-(v2*1) then
				printa := 1;
			end if;	
		end if;
		
		if a>= 315 and a <= 325 then
			flaga6 := 1;
			else 
			flaga6 := 0; 
		end if;

		--carrinho azul 2 
		if vertical_counter >=320 AND vertical_counter <=340 then
			if horizontal_counter >= 140+(a2*1) AND horizontal_counter <= 160+(a2*1) then
				printa := 2;
			end if;	 
		end if;
		
		if a>= 315 and a <= 325 then
			flaga7 := 1;
			else 
			flaga7 := 0; 
		end if;
		
		-- carrinho marelo 3
		if vertical_counter >=360 AND vertical_counter <=380  then
			if horizontal_counter >= 760-(m*2) AND horizontal_counter <= 780-(m*2) then
				printa := 3;
			end if;	
		end if;
		
		if a>= 315 and a <= 325 then
			flaga8 := 1;
			else 
			flaga8 := 0; 
		end if;
		
		--carrinho azul 3 
		if vertical_counter >=400 AND vertical_counter <=420 then
			if horizontal_counter >= 140+(a3*1) AND horizontal_counter <= 160+(a3*1) then
				printa := 2;
			end if;	 
		end if;
		
		if a>= 315 and a <= 325 then
			flaga9 := 1;
			else 
			flaga9 := 0; 
		end if;
		
	--BIXO
			if vertical_counter >=40+(b*1) AND vertical_counter <=50+(b*1) then
				if horizontal_counter >= 455 AND horizontal_counter <= 465 then
				printa :=1;
				end if;	 
			end if;
			
		if b >= 60	and b <= 80 then
		flag := 1;
		else 
		flag := 0;
		end if;
	
	--FLAG
	if flag = 1 and flaga1 =1 then
	if vertical_counter >=40 AND vertical_counter <=520 then
			if horizontal_counter >= 140 AND horizontal_counter <= 780 then
				printa := 2;
			end if;	 
		end if;	
	end if;
	
		
-- ESCOLHE COR QUE APARECERÁ NA TELA -> 0 PARA BRANCO (FUNDO
---DO JOGO), 1 PARA VERMELHO (OBSTÁCULOS) E 2 PARA AZUL (JOGADOR)
			if printa= 0 then
				red_out <= '1';
				green_out <= '1';
				blue_out <= '1';
			elsif printa= 1 then
				red_out <= '1';
				green_out <= '0';
				blue_out <= '0';
			elsif printa = 2 then
				red_out <= '0';
				green_out <= '0';
				blue_out <= '1';
			elsif printa = 3 then
				red_out <= '1';
				green_out <= '1';
				blue_out <= '0';
			elsif printa = 4 then
				red_out <= '0';
				green_out <= '1';
				blue_out <= '0';	
			else 
				red_out <= '0';
				green_out <= '0';
				blue_out <= '0';
			end if;
		else
-- ESCOLHE COR PRETA PARA RESTO DA TELA
			red_out <= '0';
			green_out <= '0';
			blue_out <= '0';
		end if;
	if (horizontal_counter > "0000000000" )
	and (horizontal_counter < "0001100001" ) -- 96+1
	then
		hs_out <= '0';
	else
		hs_out <= '1';
	end if;
	if (vertical_counter > "0000000000" )
	and (vertical_counter < "0000000011" ) -- 2+1
	then
		vs_out <= '0';
	else 
		vs_out <= '1';
	end if;
	horizontal_counter <= horizontal_counter+"0000000001";
	if (horizontal_counter="1100100000") then
		vertical_counter <= vertical_counter+"0000000001";
		horizontal_counter <= "0000000000";
	end if;
	if (vertical_counter="1000001001") then
		vertical_counter <= "0000000000";
	end if;
end if;
end process;
end Behavioral;