package svgimport;

import svgimport.gradients.GradientType;

enum StrokeType
{
	StrokeNone;
	StrokeSolid(color:String);
	StrokeGrad(gradType:GradientType);
}

