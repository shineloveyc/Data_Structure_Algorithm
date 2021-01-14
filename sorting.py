

test_arr = [31,41,59,26,41,58]


#implement insert sorted
def insert_sort(A):
    #sort list of array into ascending orders
    for k in range(1, len(A)):
        cur = A[k]  #current element to be inserted
        j=k
        while j>0 and A[j-1]>cur:
            A[j] = A[j-1]   #exchange when larger than current
            j-=1
        A[j]=cur


insert_sort(test_arr)



#implement increase insert sort
def increase_sort(array):
  for j in range(1, len(array)):
      key =array[j]
      i=j-1
      while i>=0 and array[i]>key:
          array[i+1]=array[i]
          i=i-1
      #no change if previous less than current key
      array[i+1]=key
   return array



increase_sort(test_arr)

#implement decrease inset sort
def decrease_sort(array):
  for j in range(1, len(array)):
      key =array[j]
      i=j-1
      #make sure all the value before j-1 gets sorted
      while i>=0 and array[i]<key:
          array[i+1]=array[i]
          i=i-1
      #no change if previous less than current key
      array[i+1]=key
   return array

decrease_sort(test_arr)


#implement selection sort
def select_sort(array):
    for j in range(len(array)):
        small = array[j]
        for i in range(j, len(array)):
            if array[i]<small:
                small = array[i]
                array[i]=array[j]
            else:
                small=small
        array[j]=small
    return array

select_sort(test_arr)


A = [3, 41,52,26,38,57,9,49]

#implement merge sort
def merge(arr, l, m, r):
    n1 = m - l + 1
    n2 = r- m

    # create temp arrays
    L = [0] * (n1)
    R = [0] * (n2)

    # Copy data to temp arrays L[] and R[]
    for i in range(0 , n1):
        L[i] = arr[l + i]

    for j in range(0 , n2):
        R[j] = arr[m + 1 + j]

    # Merge the temp arrays back into arr[l..r]
    i = 0     # Initial index of first subarray
    j = 0     # Initial index of second subarray
    k = l     # Initial index of merged subarray

    while i < n1 and j < n2 :
        if L[i] <= R[j]:
            arr[k] = L[i]
            i += 1
        else:
            arr[k] = R[j]
            j += 1
        k += 1

    # Copy the remaining elements of L[], if there
    # are any
    while i < n1:
        arr[k] = L[i]
        i += 1
        k += 1

    # Copy the remaining elements of R[], if there
    # are any
    while j < n2:
        arr[k] = R[j]
        j += 1
        k += 1

# l is for left index and r is right index of the
# sub-array of arr to be sorted
def mergeSort(arr,l,r):
    if l < r:

        # Same as (l+r)//2, but avoids overflow for
        # large l and h
        m = (l+(r-1))//2

        # Sort first and second halves
        mergeSort(arr, l, m)
        mergeSort(arr, m+1, r)
        #merge happens when recursion end
        merge(arr, l, m, r)


# Driver code to test above
arr = [12, 11, 13, 5, 6, 7]
n = len(arr)
print ("Given array is")
for i in range(n):
    print ("%d" %arr[i]),

mergeSort(arr,0,n-1)
print ("\n\nSorted array is")
for i in range(n):
    print ("%d" %arr[i]),
