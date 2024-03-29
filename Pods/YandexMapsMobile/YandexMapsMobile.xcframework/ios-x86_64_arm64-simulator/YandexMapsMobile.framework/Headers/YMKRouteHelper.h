#import <YandexMapsMobile/YMKJamStyle.h>
#import <YandexMapsMobile/YMKPolyline.h>

#import <UIKit/UIKit.h>

@class YMKDrivingRoute;
@class YMKManeuverStyle;

/**
 * Polygon maneuver render mode.
 */
typedef NS_ENUM(NSUInteger, YMKPolygonManeuverRenderMode) {
    /**
     * Polygon maneuver is colored as jams, trajectory is rendered with
     * color specified in style.
     */
    YMKPolygonManeuverRenderModeColoredPolygon,
    /**
     * Trajectory is colored as jams, polygon maneuver is filled with
     * colored specified in style.
     */
    YMKPolygonManeuverRenderModeColoredTrajectory
};

/**
 * The style that is used to display arrow maneuvers on the map.
 */
@interface YMKArrowManeuverStyle : NSObject

/**
 * Fill color of the arrow.
 */
@property (nonatomic, readonly, nonnull) UIColor *fillColor;

/**
 * Color of the arrow's outline.
 */
@property (nonatomic, readonly, nonnull) UIColor *outlineColor;

/**
 * Width of the arrow's outline in units.
 */
@property (nonatomic, readonly) float outlineWidth;

/**
 * Overall length of the arrow (including the tip) in units.
 */
@property (nonatomic, readonly) float length;

/**
 * Height of the arrow tip in units.
 */
@property (nonatomic, readonly) float triangleHeight;

/**
 * Enables/disables arrow maneuvers.
 */
@property (nonatomic, readonly) BOOL enabled;


+ (nonnull YMKArrowManeuverStyle *)arrowManeuverStyleWithFillColor:(nonnull UIColor *)fillColor
                                                      outlineColor:(nonnull UIColor *)outlineColor
                                                      outlineWidth:( float)outlineWidth
                                                            length:( float)length
                                                    triangleHeight:( float)triangleHeight
                                                           enabled:( BOOL)enabled;


@end

/**
 * The style that is used to display polygon maneuvers and trajectories
 * on the map.
 */
@interface YMKPolygonManeuverStyle : NSObject

/**
 * Width of trajectory line on polygon maneuvers. Used only
 * ColoredPolygon render mode.
 */
@property (nonatomic, readonly) float trajectoryWidth;

/**
 * Color of trajectory line on polygon maneuvers. Used only
 * ColoredPolygon render mode.
 */
@property (nonatomic, readonly, nonnull) UIColor *trajectoryColor;

/**
 * Polygon maneuver alpha.
 */
@property (nonatomic, readonly) float polygonAlpha;

/**
 * Color of polygon maneuver. Used only ColoredTrajectory render mode.
 */
@property (nonatomic, readonly, nonnull) UIColor *polygonColor;

/**
 * Polygon maneuver render mode.
 */
@property (nonatomic, readonly) YMKPolygonManeuverRenderMode renderMode;

/**
 * In meters.
 */
@property (nonatomic, readonly) float fadeDistance;

/**
 * Must be in range [0, 1], where 0 means invisibility.
 */
@property (nonatomic, readonly) float fadeAlpha;

/**
 * Enables/disables polygon maneuvers.
 */
@property (nonatomic, readonly) BOOL enabled;


+ (nonnull YMKPolygonManeuverStyle *)polygonManeuverStyleWithTrajectoryWidth:( float)trajectoryWidth
                                                             trajectoryColor:(nonnull UIColor *)trajectoryColor
                                                                polygonAlpha:( float)polygonAlpha
                                                                polygonColor:(nonnull UIColor *)polygonColor
                                                                  renderMode:( YMKPolygonManeuverRenderMode)renderMode
                                                                fadeDistance:( float)fadeDistance
                                                                   fadeAlpha:( float)fadeAlpha
                                                                     enabled:( BOOL)enabled;


@end

/**
 * The style that is used to display maneuvers on the map.
 */
@interface YMKManeuverStyle : NSObject

/**
 * Arrow maneuver style.
 */
@property (nonatomic, readonly, nonnull) YMKArrowManeuverStyle *arrow;

/**
 * Polygon maneuver style.
 */
@property (nonatomic, readonly, nonnull) YMKPolygonManeuverStyle *polygon;


+ (nonnull YMKManeuverStyle *)maneuverStyleWithArrow:(nonnull YMKArrowManeuverStyle *)arrow
                                             polygon:(nonnull YMKPolygonManeuverStyle *)polygon;


@end

/**
 * Undocumented
 */
@interface YMKRouteHelper : NSObject

/**
 * Creates a default traffic style. Default values: colors : Blocked  :
 * 0x000000ff, Free     : 0x00ff00ff, Hard     : 0xff0000ff, Light    :
 * 0xffff00ff, Unknown  : 0x909090ff, VeryHard : 0xa00000ff
 */
+ (nonnull YMKJamStyle *)createDefaultJamStyle;

/**
 * Creates a disabled traffic jams style. Colors : Blocked  :
 * 0x909090ff, Free     : 0x909090ff, Hard     : 0x909090ff, Light    :
 * 0x909090ff, Unknown  : 0x909090ff, VeryHard : 0x909090ff
 */
+ (nonnull YMKJamStyle *)createDisabledJamStyle;

/**
 * Creates a default maneuver style.
 *
 * Default values for ArrowManeuverStyle: fillColor      : 0x000000ff
 * outlineColor   : 0xffffffff outlineWidth   : 2.f length         : 80
 * triangleHeight : 16 enabled        : false
 *
 * Default values for PolygonManeuverStyle: trajectoryWidth : 5.f
 * trajectoryColor : 0xffffffff polygonAlpha    : 60.f / 255.f
 * polygonColor    : 0xff00ffff renderMode      : ColoredPolygon
 * fadeDistance    : 10.f fadeAlpha       : 0.f enabled         : false
 */
+ (nonnull YMKManeuverStyle *)createDefaultManeuverStyle;

/**
 * Sets a new geometry and colors for a polyline. If style.enabled =
 * false, the polyline is drawn using the color for the Unknown traffic
 * jam type. If updateGeometry = false, but route geometry differs from
 * polyline geometry, then behaviour is undefined.
 */
+ (void)updatePolylineWithPolyline:(nonnull YMKPolylineMapObject *)polyline
                             route:(nonnull YMKDrivingRoute *)route
                             style:(nonnull YMKJamStyle *)style
                    updateGeometry:(BOOL)updateGeometry;

/**
 * Add maneuvers from provided route as arrows Behaviour is undefined if
 * route.geometry does not equals polyline.geometry.
 */
+ (void)addManeuversWithPolyline:(nonnull YMKPolylineMapObject *)polyline
                           route:(nonnull YMKDrivingRoute *)route;

/**
 * Add jams from provided route as stroke colors Behaviour is undefined
 * if route.geometry does not equals polyline.geometry.
 */
+ (void)addJamsWithPolyline:(nonnull YMKPolylineMapObject *)polyline
                      route:(nonnull YMKDrivingRoute *)route;

/**
 * Applies the traffic jam style. Updates colors for traffic jam types
 * provided in the style parameter.
 */
+ (void)applyJamStyleWithPolyline:(nonnull YMKPolylineMapObject *)polyline
                            style:(nonnull YMKJamStyle *)style;

/**
 * Applies a maneuver style. This method should be called every time
 * after updatePolyline with updateGeometry == true occurs; otherwise,
 * the default maneuver style is applied.
 */
+ (void)applyManeuverStyleWithPolyline:(nonnull YMKPolylineMapObject *)polyline
                                 style:(nonnull YMKManeuverStyle *)style;

@end
