package svgimport;

import svgimport.gradients.GradientType;

enum FillType
{
	FillNone;
	FillSolid(color:String);
	FillGrad(gradType:GradientType);
}
