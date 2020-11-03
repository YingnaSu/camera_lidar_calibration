# two-step approach to Lidar-Camera calibration
Abstract —— We propose a two-step approach (coarse + fine) for the external calibration between a camera and a multiple-line Lidar. First, a new closed-form solution is proposed to obtain the initial calibration parameters. With the initial calibration parameters, the ICP-based calibration framework is used to register the point clouds which extracted from the camera and Lidar coordinate frames, respectively. Our method has been applied to two Lidarcamera systems: an HDL-64E Lidar-camera system, and a VLP-16 Lidar-camera system.

* flowchart:
<img src="https://github.com/YingnaSu/camera_lidar_calibration/blob/main/image/flowchart.png" width="600" height="180"/>

* coarse calibration:
<img src="https://github.com/YingnaSu/camera_lidar_calibration/blob/main/image/coarse_calib.png" width="300" height="200"/>

* fine calibration:
<img src="https://github.com/YingnaSu/camera_lidar_calibration/blob/main/image/calires.png" width="600" height="150"/>

* results:
<img src="https://github.com/YingnaSu/camera_lidar_calibration/blob/main/image/res.png" width="600" height="240"/>

----------------------------------------------------------------------------
Please cite the paper when referring to Lidar-Camera-Calibration in general:

Yingna Su, Yaqing Ding, et al. A two-step approach to Lidar-Camera calibration. ICPR, 2020.
