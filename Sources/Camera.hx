package;
import kha.System;
import kha.math.Vector3;
import kha.graphics4.ConstantLocation;
import kha.math.FastVector3;
import kha.math.FastMatrix4;

class Camera {

	public var view:FastMatrix4;
	public var projection:FastMatrix4;

	public var position: FastVector3 = new FastVector3(7.35, 6.51, -6.92);
	public var up: FastVector3 = new FastVector3(0, 1, 0);
  
    public var yFov = 45.0;
	public var aspect = 4.0/3.0;
	public var zNear = 0.1;
	public var zFar = 100.0;

	public function new() {
		aspect = System.windowWidth()/System.windowHeight();
		projection = FastMatrix4.perspectiveProjection(yFov, aspect, zNear, zFar);// 1
		view = FastMatrix4.lookAt(position, new FastVector3(0.0, 0.0, 0.0), up);// 2
	}
}