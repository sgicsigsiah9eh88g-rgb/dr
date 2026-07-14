-- ==========================================
-- COMUNIDADE SCRIPTER - MENU MULTIFUNCIONAL
-- ==========================================

-- Configurações de Estilo da Interface
local Menu = {
    Nome = "Comunidade Scripter",
    Versao = "1.0",
    Visivel = true,
    CorBorda = "\27[35m", -- Magenta (Simulação de cor no console)
    CorTexto = "\27[36m", -- Ciano
    ResetCor = "\27[0m"
}

-- Animação simples de carregamento (Efeito de digitação/piscar)
local function ExecutarAnimacaoIntro()
    local titulo = "=== " .. Menu.Nome .. " ==="
    for i = 1, #titulo do
        io.write(Menu.CorBorda .. string.sub(titulo, 1, i) .. "\r")
        io.flush()
        os.execute("sleep 0.05") -- Pequeno delay para a animação
    end
    print("\n" .. Menu.CorTexto .. "Carregando as melhores funções para você..." .. Menu.ResetCor)
    os.execute("sleep 1")
end

-- ==========================================
-- 10 FUNÇÕES MAIS UTILIZADAS EM JOGOS
-- ==========================================

local CheatEngine = {
    -- 1. Velocidade (Speed)
    [1] = {
        nome = "Speed Hack (Velocidade)",
        ativo = false,
        executar = function(self)
            self.ativo = not self.ativo
            print(">> [Speed Hack] " .. (self.ativo and "ATIVADO! (Velocidade aumentada)" or "DESATIVADO!"))
            -- Aqui entraria o código do jogo, ex: localPlayer.Character.Humanoid.WalkSpeed = 100
        end
    },
    -- 2. Voar (Fly)
    [2] = {
        nome = "Fly Hack (Voo)",
        ativo = false,
        executar = function(self)
            self.ativo = not self.ativo
            print(">> [Fly Hack] " .. (self.ativo and "ATIVADO!" or "DESATIVADO!"))
            -- Ex: Ativar BodyVelocity ou gravidade zero no personagem
        end
    },
    -- 3. Dinheiro Infinito (Money)
    [3] = {
        nome = "Infinite Money (Simulação Local)",
        ativo = false,
        executar = function(self)
            print(">> [Money] Adicionando $999,999,999 à sua conta local!")
            -- Ex: game.Players.LocalPlayer.leaderstats.Money.Value = 99999999
        end
    },
    -- 4. Super Pulo (Super Jump)
    [4] = {
        nome = "Super Jump (Super Pulo)",
        ativo = false,
        executar = function(self)
            self.ativo = not self.ativo
            print(">> [Super Jump] " .. (self.ativo and "ATIVADO!" or "DESATIVADO!"))
        end
    },
    -- 5. Vida Infinita (God Mode)
    [5] = {
        nome = "God Mode (Vida Infinita)",
        ativo = false,
        executar = function(self)
            self.ativo = not self.ativo
            print(">> [God Mode] " .. (self.ativo and "ATIVADO!" or "DESATIVADO!"))
        end
    },
    -- 6. Teleporte para o Objetivo (TP to Objective)
    [6] = {
        nome = "Teleport to Waypoint (Teleporte)",
        ativo = false,
        executar = function(self)
            print(">> [Teleport] Teleportado para o destino marcado com sucesso!")
        end
    },
    -- 7. Atravessar Paredes (Noclip)
    [7] = {
        nome = "Noclip (Atravessar Paredes)",
        ativo = false,
        executar = function(self)
            self.ativo = not self.ativo
            print(">> [Noclip] " .. (self.ativo and "ATIVADO!" or "DESATIVADO!"))
        end
    },
    -- 8. Mira Automática (Aimbot)
    [8] = {
        nome = "Aimbot (Mira Automática)",
        ativo = false,
        executar = function(self)
            self.ativo = not self.ativo
            print(">> [Aimbot] " .. (self.ativo and "ATIVADO!" or "DESATIVADO!"))
        end
    },
    -- 9. Ver através das paredes (ESP / Wallhack)
    [9] = {
        nome = "ESP (Ver Jogadores/Itens)",
        ativo = false,
        executar = function(self)
            self.ativo = not self.ativo
            print(">> [ESP] " .. (self.ativo and "ATIVADO!" or "DESATIVADO!"))
        end
    },
    -- 10. Munição Infinita (Infinite Ammo)
    [10] = {
        nome = "Infinite Ammo (Munição Infinita)",
        ativo = false,
        executar = function(self)
            self.ativo = not self.ativo
            print(">> [Ammo] " .. (self.ativo and "ATIVADO!" or "DESATIVADO!"))
        end
    }
}

-- ==========================================
-- RENDERIZAÇÃO DA INTERFACE COM BORDAS
-- ==========================================

local function DesenharMenu()
    -- Limpa a tela (compatível com Windows e Linux/macOS)
    if os.getenv("OS") == "Windows_NT" then
        os.execute("cls")
    else
        os.execute("clear")
    end

    local bordaHorizontal = "=================================================="
    
    print(Menu.CorBorda .. bordaHorizontal .. Menu.ResetCor)
    print(Menu.CorBorda .. "|| " .. Menu.CorTexto .. string.format("%-44s", Menu.Nome .. " v" .. Menu.Versao) .. Menu.CorBorda .. " ||")
    print(Menu.CorBorda .. "|| " .. Menu.CorTexto .. string.format("%-44s", "Comunidade: Scripter Hub") .. Menu.CorBorda .. " ||")
    print(Menu.CorBorda .. bordaHorizontal .. Menu.ResetCor)

    -- Lista as 10 opções dinamicamente
    for id, opcao in ipairs(CheatEngine) do
        local status = opcao.ativo and "[ATIVADO]" or "[DESATIVADO]"
        local textoOpcao = string.format("[%d] %-30s %s", id, opcao.nome, status)
        print(Menu.CorBorda .. "|| " .. Menu.CorTexto .. string.format("%-44s", textoOpcao) .. Menu.CorBorda .. " ||")
    end

    print(Menu.CorBorda .. "|| " .. Menu.CorTexto .. string.format("%-44s", "[0] Sair do Menu") .. Menu.CorBorda .. " ||")
    print(Menu.CorBorda .. bordaHorizontal .. Menu.ResetCor)
    io.write("Escolha uma opção: ")
end

-- ==========================================
-- LOOP PRINCIPAL DO SCRIPT
-- ==========================================

ExecutarAnimacaoIntro()

while Menu.Visivel do
    DesenharMenu()
    local escolha = tonumber(io.read())

    if escolha == 0 then
        Menu.Visivel = false
        print("Menu fechado. Obrigado por usar o script da Comunidade Scripter!")
    elseif escolha and CheatEngine[escolha] then
        -- Executa a função escolhida
        CheatEngine[escolha]:executar()
        -- Pausa rápida para o usuário ver o feedback antes de redesenhar a tela
        os.execute("sleep 1.5")
    else
        print("Opção inválida! Tente novamente.")
        os.execute("sleep 1")
    end
end
