import sys

cache: dict[str, int] = {}

# returns how many the stone will be after blinking (blinks) times
def blink(stone: int, blinks: int) -> int:
    if blinks == 0:
        return 1
    if (stone, blinks) in cache:
        return cache[(stone, blinks)]

    if stone == 0:
        result = blink(1, blinks - 1)
    elif len(str(stone)) % 2 == 0:
        str_stone = str(stone)
        half = len(str_stone) // 2
        fst = int(str_stone[: half])
        snd = int(str_stone[half:])
        result = blink(fst, blinks - 1) + blink(snd, blinks - 1)
    else:
        result = blink(stone * 2024, blinks - 1)

    cache[(stone, blinks)] = result
    return result



def solve(input: list[int], count: int) -> int:
    """
    >>> solve([125, 17], 25)
    55312
    """
    ret = 0
    for stone in input:
        ret += blink(stone, count)
    return ret


def test():
    import doctest

    doctest.testmod()


if __name__ == "__main__":
    part = sys.argv[1]
    if part == "test":
        test()
    else:
        file = sys.argv[2]
        with open(file) as file:
            input = list(map(int, file.read().split(" ")))
            if part == "1" or part == "part1":
                print(solve(input, 25))
            elif part == "2" or part == "part2":
                print(solve(input, 75))
