shader_type canvas_item;

// Colors predeterminats agafats de les llistes proporcionades
uniform vec3 Face_color : source_color = vec3(0.706, 0.322, 0.227);  // Pèl roig
uniform vec3 Body_color : source_color = vec3(0.878, 0.804, 0.663); // Beix brillant
uniform vec3 Hair_color : source_color = vec3(0.545, 0.369, 0.235);  // Verd salvia brillant

void vertex() {
}

void fragment() {
    // Separar els components del color original
    vec3 no_red = COLOR.rgb * vec3(0.0, 1.0, 1.0);   // Eliminar el vermell
    vec3 no_green = COLOR.rgb * vec3(1.0, 0.0, 1.0); // Eliminar el verd
    vec3 no_blue = COLOR.rgb * vec3(1.0, 1.0, 0.0);  // Eliminar el blau

    // Mida dels components eliminats
    float amount_of_red = length(no_red);
    float amount_of_green = length(no_green);
    float amount_of_blue = length(no_blue);

    // Màscares per identificar quins colors són dominants
    float red_mask = step(0.01, amount_of_red);
    float green_mask = step(0.01, amount_of_green);
    float blue_mask = step(0.01, amount_of_blue);

    // Substituir cada component pel color corresponent si és dominant
    vec3 replaced_red = (1.0 - red_mask) * COLOR.r * Face_color;
    vec3 replaced_green = (1.0 - green_mask) * COLOR.g * Body_color;
    vec3 replaced_blue = (1.0 - blue_mask) * COLOR.b * Hair_color;

    // Retenir els altres colors no afectats
    vec3 retained_color = red_mask * green_mask * blue_mask * COLOR.rgb;

    // Aplicar els canvis
    COLOR.rgb = retained_color + replaced_red + replaced_green + replaced_blue;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
