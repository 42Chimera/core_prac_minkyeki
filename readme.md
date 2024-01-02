### Cmake command
```bash
cmake -B build --> defaults to Debug build.
cmake -DCMAKE_BUILD_TYPE=Debug
cmake -DCMAKE_BUILD_TYPE=Release
```

### Full commmand for Debug build + execute program
```bash
rm -rf build && cmake -DCMAKE_BUILD_TYPE=Debug -B build && make -C build -j4 && ./build/chimera
```

### TODO
0. SHARED LIB 링크하는 걸로 했지만, makefile 보니 링크하는게 없네...? 이거 동적 라이브러리 링킹이 아닌가?
0. UTIL_assert.h 인클루드 안되는 이유 찾아내서 고치기. 
 --> 1. PRIVATE, INTERFACE, PUBLIC 이해하기
1. 각 모듈들 인클루드 규칙 정하기 + prefix 이름 규칙. -> 헤더 인클루드시 
2. CM_DEBUG 같은 매크로 빌드 모드에 따라 다르게 해주기.
3. CMAKE 빌드 돌리면 DEFINE_SYMBOL32를 파싱해서, 그에 따른 enum과 manager의 String Table을 만들어주면 안될까?

### Header Predix Rule (추후 추가 예정)
ITERN_* : chimera internal library. ex. "INTERN_libcm.h"

### Event System 
각 창에서 이벤트 콜백을 구현한다.
관련해서 붙힐 이벤트는 정의되어 있다.
UI Context에서 붙힐 수 있는 이벤트 종류 (그리고 각 UI 특성에 따라 해당 콜백이 처리될지 말지 )

### EventDispatcher
application에서 발생한 Event를 아래 EventType에 맞게 형변환.
EventDispatcher(Event).Dispatch( func )

### EventHandler

### EventType
- Event --> Event::Type
  - ResizeEvent
  - PaintEvent
  - MouseEvent
  - KeyEvent
  - CloseEvent
```cpp
void MyCheckBox::OnMousePress(MouseEvent *event)
{
    if (event->button() == Cm::LeftButton) {
        // handle left mouse button here
    } else {
        // pass on other buttons to base class
        QCheckBox::mousePressEvent(event);
    }
}
```
### All event delivered in event queue.