def medir_satisfação():
    """Mede o nível de satisfação de um cliente"""
    while True:
        try:
            nível_satisfação = int(input("Insira a sua nota de satisfação (1 à 100): "))

            if 100 >= nível_satisfação >= 90:
                return "Excelente!"
            elif 89 >= nível_satisfação >= 70:
                return "Neutro!"
            elif 0 < nível_satisfação < 70:
                return "Insatisfatório!"
            else:
                print("Nota de satisfação inválida, digite um número entre 1 e 100!")
                continue
        except ValueError:
            print("Nota de satisfação inválida, digite um valor numérico!")


classificação = medir_satisfação()

print(f"Nível de satisfação: {classificação}")
