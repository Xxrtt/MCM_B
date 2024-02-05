import pulp
import matplotlib.pyplot as plt


def main():
    bonus_values = range(0, 10000, 500)  # Adjust the range as needed
    results = []

    for bonus in bonus_values:
        InvestLP = pulp.LpProblem("Invest decision problem", sense=pulp.LpMinimize)
        x1 = pulp.LpVariable('水下摄像头', cat='Binary')
        x2 = pulp.LpVariable('侧扫声纳', cat='Binary')
        x3 = pulp.LpVariable('水上无人机', cat='Binary')
        x4 = pulp.LpVariable('GPS定位仪', cat='Binary')
        x5 = pulp.LpVariable('AUV', cat='Binary')
        x6 = pulp.LpVariable('ROV', cat='Binary')
        x7 = pulp.LpVariable('激光测距仪', cat='Binary')
        x8 = pulp.LpVariable('卫星通讯设备', cat='Binary')
        # x1 = pulp.LpVariable('医疗急救箱', cat='Binary')
        # x2 = pulp.LpVariable('救生衣', cat='Binary')
        # x3 = pulp.LpVariable('救生圈', cat='Binary')
        # x4 = pulp.LpVariable('AED', cat='Binary')
        # x5 = pulp.LpVariable('橡皮艇', cat='Binary')
        # InvestLP += (
        #             0.03006697 * x1 - 0.10405606 * x2 - 0.05506321 * x3 + 0.08490355 * x4 + 0.08641467 * x5)  # set f(x)
        # InvestLP += (400 * x1 + 350 * x2 + 200 * x3 + 24800 * x4 + 700 * x5 <= bonus)
        # InvestLP += (x1 >= 0)
        # InvestLP += (x2 >= 0)
        # InvestLP += (x3 >= 0)
        # InvestLP += (x4 >= 0)
        # InvestLP += (x5 >= 0)
        InvestLP += (
                    -0.800076 * x1 - 1.71008611 * x2 - 0.34844927 * x3 - 2.27263095 * x4 - 2.2057447 * x5 - 1.42705873 * x6 - 1.85002984 * x7 - 2.84219158 * x8)
        InvestLP += (
                    460 * x1 + 4800 * x2 + 3000 * x3 + 980 * x4 + 431000 * x5 + 819000 * x6 + 7800 * x7 + 5100 * x8 <= bonus)
        InvestLP += (x1 >= 0)
        InvestLP += (x2 >= 0)
        InvestLP += (x3 >= 0)
        InvestLP += (x4 >= 0)
        InvestLP += (x5 >= 0)
        InvestLP += (x6 >= 0)
        InvestLP += (x7 >= 0)
        InvestLP += (x8 >= 0)

        InvestLP.solve()
        results.append([v.varValue for v in InvestLP.variables()])

    # Visualize the results
    variable_names = ['AUV', 'GPS Locater', 'ROV', 'Side-scan Sonar', 'Satellite Locater','UAV','Magnetic Rangefinder','Laser Rangefinder']
    for i in range(len(variable_names)):
        plt.plot(bonus_values, [result[i] for result in results], label=variable_names[i])
    plt.title('host shi')
    plt.xlabel('Bonus Value')
    plt.ylabel('Variable Value')

    # Adjust label font size
    plt.xticks(fontsize=8)
    plt.yticks(fontsize=8)

    # Move legend to upper right corner
    plt.legend(loc='right', prop={'size': 8})

    plt.show()


if __name__ == '__main__':
    main()
