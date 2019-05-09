void myCustomRenderer(World world) {

 
  // iterate through the bodies
  Body body;
  for (body = world.getBodyList(); body != null; body = body.getNext()) {
 
    // iterate through the shapes of the body
    org.jbox2d.collision.Shape shape;
    for (shape = body.getShapeList(); shape != null; shape = shape.getNext()) {
 
      // find out the shape type
      ShapeType st = shape.getType();
      if (st == ShapeType.POLYGON_SHAPE) {
 
        // polygon? let's iterate through its vertices while using begin/endShape()
        beginShape();
        PolygonShape poly = (PolygonShape) shape;
        int count = poly.getVertexCount();
        noFill();
        stroke(255, 0, 0);
        noStroke(); 
        Vec2[] verts = poly.getVertices();
        for(int i = 0; i < count; i++) {
          Vec2 vert = physics.worldToScreen(body.getWorldPoint(verts[i]));
          vertex(vert.x, vert.y);
        }
        Vec2 firstVert = physics.worldToScreen(body.getWorldPoint(verts[0]));
        vertex(firstVert.x, firstVert.y);
        endShape();
 
      }
      else if (st == ShapeType.CIRCLE_SHAPE) {
 
        // circle? let's find its center and radius and draw an ellipse
        CircleShape circle = (CircleShape) shape;
        Vec2 pos = physics.worldToScreen(body.getWorldPoint(circle.getLocalPosition()));
        float radius = physics.worldToScreen(circle.getRadius());
        ellipseMode(CENTER);
        stroke(255);
        ellipse(pos.x, pos.y, radius*2, radius*2);
        // we'll add one more line to see how it rotates
        line(pos.x, pos.y, pos.x + radius*cos(-body.getAngle()), pos.y + radius*sin(-body.getAngle()));
 
      }
    }
  }
}
