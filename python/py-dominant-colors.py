# adapted from http://charlesleifer.com/blog/using-python-and-k-means-to-find-the-dominant-colors-in-images/
# used kmeans from scipy instead of some hand-written solution

from pylab import imread, imshow, figure, show, subplot
from numpy import reshape, uint8, flipud
from scipy.cluster.vq import kmeans, vq
from pprint import pprint

img = imread('screenshot.jpg')

# reshape pixel matrix
pixel = reshape(img, (img.shape[0]*img.shape[1], 3))

# perform clustering
centroids, _ = kmeans(pixel, 3, 5) # 3 colors, 5 iterations

rtoh = lambda rgb: '#%s' % ''.join(('%02x' % p for p in rgb))

rgbs = [map(int, c) for c in centroids]
color_hex  = map(rtoh, rgbs)

pprint(color_hex)
