shader_type canvas_item;
uniform bool buildable;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	if(COLOR.a>0.0){
		if(buildable){
			COLOR*=vec4(1,2,1,0.8);
		}
		else{
			COLOR*=vec4(2,1,1,0.8);
		}
	}
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
