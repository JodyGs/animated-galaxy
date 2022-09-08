uniform float uSize;
uniform float uTime;

attribute vec3 aRandomness;
attribute float aScale;

varying vec3 vColor;

void main() {
  /**
  * Position
  */
  vec4 modelPosition = modelMatrix * vec4(position, 1.0);

  // Rotate
  float angle = atan(modelPosition.x, modelPosition.z);
  float distanceToCenter = length(modelPosition.xz);
  float angleOffset = (1.0 / distanceToCenter) * uTime * 0.1;
  angle += angleOffset;
  modelPosition.z = sin(angle) * distanceToCenter;
  modelPosition.x = cos(angle) * distanceToCenter;

  // Randomness
  modelPosition.xyz += aRandomness;

  vec4 viewPosition = viewMatrix * modelPosition;
  vec4 projectedPosition = projectionMatrix * viewPosition;

  gl_Position = projectedPosition;

  /**
  * Size
  */
  gl_PointSize = uSize * aScale;
  gl_PointSize *= (1.0 / -viewPosition.z);

  vColor = color;
}