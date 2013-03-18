

//polygon( points=[[0,0],[2,1],[1,2],[1,3],[3,4],[0,5]] );

//rotate_extrude($fn=200) polygon( points=[[0,0],[2,1],[1,2],[1,3],[3,4],[0,5]] );


linear_extrude(height = 20, center = true, convexity = 10, twist = -fanrot, slices = 20) {
	circle(r = 10);
}