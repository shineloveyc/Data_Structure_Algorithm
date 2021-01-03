"""Implement quick sort in Python.
Input a list.
Output a sorted list."""

def quicksort(array):
    qs(array, 0, len(array) - 1)
    return array

def qs(array, l, r):
#left bound and right bound
#base case ==>left index must less than right, if equal, point the same number
    if l >= r:
        return
    p = partition(array, l, r)

   #recursion function
    qs(array, l, p - 1)
    qs(array, p + 1, r)

#choose a pivot==>within the partition space
def partition(arr, l, r):
    pivot = arr[r]
    i = l - 1
    for j in range(l, r):
        if arr[j] < pivot:
            i += 1
            arr[i], arr[j] = arr[j], arr[i]
    arr[i + 1], arr[r] = arr[r], arr[i + 1]
    return i + 1


test = [21, 4, 1, 3, 9, 20, 25, 6, 21, 14]
print quicksort(test)
