//resolution
$fn = 150;

//dimensions, in mm


y=127.85;
x=100.19;
z=50.5;

pyramid(x, y, z);

//pyramid making module bottom centered at origin
module pyramid(x_length, y_lenght, z_lenght){

	translate([-x_length/2,-y_lenght/2,0]) 

		polyhedron(

		points = [[0,0,0], [0,y_lenght,0], [x_length,y_lenght,0], [x_length,0,0], [x_length/2,y_lenght/2,z_lenght]], 

		triangles = [[0,1,4],[1,2,4],[2,3,4],[3,0,4],[0,3,2],[0,2,1]]);

};

