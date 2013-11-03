# step by step from here: http://mnemstudio.org/clustering-k-means-example-1.htm
# used for understanding kmeans step by step

DATASET = [
  # subject, a, b
  [1, 1.0, 1.0],
  [2, 1.5, 2.0],
  [3, 3.0, 4.0],
  [4, 5.0, 7.0],
  [5, 3.5, 5.0],
  [6, 4.5, 5.0],
  [7, 3.5, 4.5]
]

def euclid_distance(point_one, point_two)
  (point_one[1] - point_two[1]) * (point_one[1] - point_two[1]) + (point_one[2] - point_two[2]) * (point_one[2] - point_two[2]) 
end

def max_point_distance(current_point, data_set)
  puts "current_point - #{current_point}"
  max_dist   = 0
  max_point = nil
  data_set.each do |point|
    dist = euclid_distance(current_point, point)
    max_point ||= point
    if dist > max_dist
      max_dist   = dist
      max_point  = point
    end
  end
  return [max_dist, max_point]
end

# find a & b values of the two individuals furthest apart

max_dist   = 0
max_points = nil
data_set   = DATASET.dup
loop do
  break if data_set.empty?
  beg_point = data_set.shift
  cur_distance, cur_max_point = max_point_distance(beg_point, data_set)
  # puts "distance - #{distance} & max_point - #{max_point}"
  if cur_distance > max_dist
    max_dist  = cur_distance
    max_points = [beg_point, cur_max_point]
  end  
end

puts "max_dist - #{max_dist} and max_point - #{max_points}"

## other points are examined in sequence and allocated to closest cluster
data_set  = DATASET.dup # refresh it

mean_vector_one = max_points[0]
mean_vector_two = max_points[1]

def new_centroid(points)
  x_coord = 0 
  y_coord = 0
  points.each do |item|
    x_coord = x_coord + item[1]
    y_coord = y_coord + item[2]
  end
  return [-1, x_coord.to_f / points.size.to_f, y_coord.to_f / points.size.to_f]
end

c_one = []
c_two = []
data_set.each do |point|
  next if ( (point[0] == max_points[0]) || (point[1] == max_points[1]))

  distance_one = euclid_distance(mean_vector_one, point)
  distance_two = euclid_distance(mean_vector_two, point)
  puts "distance_one #{distance_one} and distance_two #{distance_two}"
  if distance_one < distance_two
    c_one << point
    # get new centroid (mean_vector)
    mean_vector_one = new_centroid(c_one)
  else
    c_two << point
    mean_vector_two = new_centroid(c_two)
  end
end

puts "cluster one: #{c_one} with mean_vector of #{mean_vector_one}"
puts "cluster_two: #{c_two} with mean_vector of #{mean_vector_two}"

# can't be sure that each individual has been assigned to the right cluster
# compare each individual distance to the cluster mean

new_c_one = []
new_c_two = []
data_set = DATASET.dup
data_set.each do |point|
  d_mv_one = euclid_distance(point, mean_vector_one)
  puts "distance to mean vector (1) #{d_mv_one}"
  d_mv_two = euclid_distance(point, mean_vector_two)
  puts "distance to mean vector (2) #{d_mv_two}" 
  if d_mv_one < d_mv_two
    new_c_one << point
  else
    new_c_two << point
  end
end

puts "new cluster one: #{new_c_one}"
puts "new cluster two: #{new_c_two}"

## keep going until no relocations, or until you stop

