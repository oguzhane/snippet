pid=$(pidof -s konsole)
if [ -z "$pid" ]
then
	exit
fi
#minimizedCMD="qdbus org.kde.konsole-$pid /konsole/MainWindow_1 org.qtproject.Qt.QWidget.minimized"
#showNormalCMD="qdbus org.kde.konsole-$pid /konsole/MainWindow_1 org.qtproject.Qt.QWidget.showNormal"
#showMinimizedCMD="qdbus org.kde.konsole-$pid /konsole/MainWindow_1 org.qtproject.Qt.QWidget.showMinimized"
#raiseCMD="qdbus org.kde.konsole-$pid /konsole/MainWindow_1 org.qtproject.Qt.QWidget.raise"
#setFocusCMD="qdbus org.kde.konsole-$pid /konsole/MainWindow_1 org.qtproject.Qt.QWidget.setFocus"
#winIdCMD="qdbus org.kde.konsole-$pid /konsole/MainWindow_1 org.kde.KMainWindow.winId"
#setHiddenCMD="qdbus org.kde.konsole-$pid /konsole/MainWindow_1 org.qtproject.Qt.QWidget.setHidden"
#visibleCMD="qdbus org.kde.konsole-$pid /konsole/MainWindow_1 org.qtproject.Qt.QWidget.visible"


winID=$(qdbus org.kde.konsole-$pid /konsole/MainWindow_1 org.kde.KMainWindow.winId)
visible=$(qdbus org.kde.konsole-$pid /konsole/MainWindow_1 org.qtproject.Qt.QWidget.visible)
isActiveWindow=$(qdbus org.kde.konsole-$pid /konsole/MainWindow_1 org.qtproject.Qt.QWidget.isActiveWindow)

if [ $visible = "true" ] && [ $isActiveWindow = "true" ]
then
	$(qdbus org.kde.konsole-$pid /konsole/MainWindow_1 org.qtproject.Qt.QWidget.setHidden true)
else
	$(qdbus org.kde.konsole-$pid /konsole/MainWindow_1 org.qtproject.Qt.QWidget.setHidden false)
	#$(qdbus org.kde.konsole-$pid /konsole/MainWindow_1 org.qtproject.Qt.QWidget.showNormal)
	#$(qdbus org.kde.konsole-$pid /konsole/MainWindow_1 org.qtproject.Qt.QWidget.raise)
	#$(qdbus org.kde.konsole-$pid /konsole/MainWindow_1 org.qtproject.Qt.QWidget.setFocus)
	$(xdotool windowactivate $winID)
	$(xdotool windowfocus $winID)
fi
