def is_prime(p):
    if p <= 1:
        return False
    for i in range(2, p):
        if p % i == 0:
            return False
    return True


def factor_extractor(n, factor_list=[]):
    if is_prime(int(n)):
        return (n, [int(x) for x in factor_list if is_prime(int(x))])
    else:
        for i in range(2, n):
            if n % i == 0:
                factor_list.extend((i, n / i))
                n /= i
                n, factor_list = factor_extractor(int(n), factor_list)


print(factor_extractor(19))