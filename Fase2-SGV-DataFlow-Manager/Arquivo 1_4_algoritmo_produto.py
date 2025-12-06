import json

# Gerando o arquivo JSON dos produtos com a função gerar_json()
def gerar_json(itens):
    with open('1_5_arquivo_produto.json', 'w', encoding="utf-8") as arquivo:
        json.dump(itens, arquivo, indent=4, ensure_ascii=False)
    print("Arquivo JSON gerado com sucesso!")

# Calculando o valor icms usando uma função lambda
calcular_icms = lambda valor: round(valor * 0.18, 2)


# Pedindo ao usuário as informações do produto com a função cadastrar_produtos()
def cadastrar_produtos():
    produtos = []
    while True:
        try:
            descricao = input("Descricao: ")
            valor = float(input("Valor: "))
            embalagem = input("Embalagem: ")

            icms = calcular_icms(valor)

            # Guardando as informações dos produtos em um dicionário
            produto = {
                "descricao": descricao,
                "valor": valor,
                "embalagem": embalagem,
                "icms": icms
            }
            produtos.append(produto)
            # Verificando se o usuário deseja cadastrar mais produtos
            while True:
                print(f"-- Produtos Cadastrados: [{len(produtos)}]")
                continuar = input("Digite \"sim\" para continuar OU \"nao\" para parar. [min: 5]: ").strip().lower()
                if continuar in ("sim", "nao"):
                    break
                else:
                    print("Digite uma opção válida...")
            if continuar == "nao":
                break
        # Mostrando um erro, caso o usuário não retorne um valor numérico válido para o preço
        except ValueError:
            print('Erro: Certifique-se de inserir um valor numérico válido para o preço.')

        # Mostrando um erro personalizado, caso algo saia do esperado
        except Exception as e:
            print(f'Erro inesperado: {e}')

    # Verificando se foi cadastrado pelo menos 5 produtos para gerar o arquivo JSON usando a função gerar_json
    if len(produtos) >= 5:
        gerar_json(produtos)
    else:
        print('Erro: Cadastre pelo menos 5 produtos.')

# Verificando se o script está sendo rodado diretamente para dar inicio à função principal
if __name__ == '__main__':
    cadastrar_produtos()
