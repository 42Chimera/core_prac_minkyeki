0. UTIL_assert.h 인클루드 안되는 이유 찾아내서 고치기. 
1. 각 모듈들 인클루드 규칙 정하기 + prefix
2. 빌드 후 실행 파일 위치를 밖으로 빼기.
3. PRIVATE, INTERFACE, PUBLIC 이해하기
4. CMAKELIST include path 반영은 cmake list의 하위 디렉토리들에게 해당되는 거구나...

### Header Predix
---
CLI_* : chimera internal library. ex. "CLI_assert.h"