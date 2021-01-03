class Classy(object):
    def __init__(self):
        self._items = []
        self._total_scores=0

    def addItem(self, item):
        self.items.append(item)
        if item=='tophat':
            self.total_scores+=2
        elif item=='bowtie':
            self.total_scores+=4
        elif item == 'monocle':
            self.total_scores+=5
        else:
            self.total_scores+=0

    def getClassiness(self):
        return self.total_scores
