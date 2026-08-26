from itertools import permutations

word = "engineering"
unique_permutations = set(permutations(word))

for perm in sorted(unique_permutations):
    print(''.join(perm))
