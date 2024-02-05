import pulp

def main():
    InvestLP = pulp.LpProblem("Invest decision problem", sense=pulp.LpMinimize)  # maximum
    # x1 = pulp.LpVariable('水下摄像头', cat='Binary')
    # x2 = pulp.LpVariable('侧扫声纳', cat='Binary')
    # x3 = pulp.LpVariable('水上无人机', cat='Binary')
    # x4 = pulp.LpVariable('GPS定位仪', cat='Binary')
    # x5 = pulp.LpVariable('AUV', cat='Binary')
    # x6 = pulp.LpVariable('ROV', cat='Binary')
    # x7 = pulp.LpVariable('激光测距仪', cat='Binary')
    # x8 = pulp.LpVariable('卫星通讯设备', cat='Binary')
    x1 = pulp.LpVariable('医疗急救箱', cat='Binary')
    x2 = pulp.LpVariable('救生衣', cat='Binary')
    x3 = pulp.LpVariable('救生圈', cat='Binary')
    x4 = pulp.LpVariable('AED', cat='Binary')
    x5 = pulp.LpVariable('橡皮艇', cat='Binary')

    bonus=10000000
    InvestLP += (0.03006697*x1-0.10405606*x2-0.05506321*x3+0.08490355*x4+0.08641467*x5)  # set f(x)
    InvestLP += (400*x1+350*x2+200*x3+24800*x4+700*x5 <= bonus)
    InvestLP += (x1 >= 0)
    InvestLP += (x2 >= 0)
    InvestLP += (x3 >= 0)
    InvestLP += (x4 >= 0)
    InvestLP += (x5 >= 0)
    # InvestLP += (x6 >= 0)
    # InvestLP += (x7 >= 0)
    # InvestLP += (x8 >= 0)
    InvestLP.solve()
    print(InvestLP.name)
    print("Status youcans:", pulp.LpStatus[InvestLP.status])
    for v in InvestLP.variables():
        print(v.name, "=", v.varValue)
    print("Min f(x) =", pulp.value(InvestLP.objective))

    return

if __name__ == '__main__':
    main()