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

test_arr = [31,41,59,26,41,58]

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
