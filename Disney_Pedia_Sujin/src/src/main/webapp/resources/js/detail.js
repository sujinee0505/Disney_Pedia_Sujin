$(function(){
	function getContextPath() {
      return sessionStorage.getItem("contextpath");
   }
   let ctx = getContextPath();
   
		/* 헤더 투명화 */
		header = function() {
		    if ($(this).scrollTop() == 0) {
		        $('#header').removeClass('css-6k8tqb').addClass('css-5brfx4');
		        $('.css-q65tx9-StylelessButton').css('color',
		            'rgba(255, 255, 255, 0.7)');
		        $('#keyword').removeClass('css-13i5xe6')
		            .addClass('css-1sc5b20');
		        $('#label').removeClass('css-kyr608').addClass('css-y4utrt');
		        $('#login-btn').removeClass('css-fn0ezc-StylelessButton')
		            .addClass('css-1n4uax5-StylelessButton');
		        $('#register-btn').removeClass('css-139vxi-StylelessButton')
		            .addClass('css-1hpk3gd-StylelessButton');
		    } else {
		        $('#header').removeClass('css-5brfx4').addClass('css-6k8tqb');
		        $('.css-q65tx9-StylelessButton').css('color', '#7e7e7e');
		        $('#keyword').removeClass('css-1sc5b20')
		            .addClass('css-13i5xe6');
		        $('#label').removeClass('css-y4utrt').addClass('css-kyr608');
		        $('#login-btn').removeClass('css-1n4uax5-StylelessButton')
		            .addClass('css-fn0ezc-StylelessButton');
		        $('#register-btn').removeClass('css-1hpk3gd-StylelessButton')
		            .addClass('css-139vxi-StylelessButton');
		    }
		}
		header();
		$(window).on('scroll', header);
		
		/* '더보기' */
		more = function() {
			var status = $('#status').text();
			if (status == '더보기') {
				$('#overview').css('display', 'block');
				$('#status').text('접기');
			} else if (status == '접기') {
				$('#overview').css('display', '-webkit-box');
				$('#status').text('더보기');
			}
		}
		$(document).ready(
				function() {
					var height = $('#overview').height();
					if (height > 96) {
						$('#overview').removeClass('css-kywn6v-StyledText')
								.addClass('css-kywn7v-StyledText');
						$('#status').show();
					}
				});
		
		var user_num = $('#user_num').val();
		var check = $('#check').val();
		
		like = function() {
				if (user_num == 0) {
					Swal.fire({			
							  title: ' ',						  
							  text: '내 보관함에 작품을 담으려면 로그인이 필요해요.',
							  imageUrl: ctx + '/resources/images/bookmark_icon.png',
							  imageWidth: 70,
							  imageHeight: 70,						  
							  imageAlt: 'Custom image',
							  confirmButtonColor: '#84d7fa',
							  confirmButtonText: '알겠어요',
							  width: 400,
							  padding: '2em'
							  })
					return;
				}
				if (user_num != 0) {
					$
							.ajax({
								url : 'contentsLike.do',
								type : 'post',
								dataType : 'json',
								data : {
									contents_num : $('#contents_num').val(),
									contents_type : $('#contents_type').val(),
									mem_num : user_num,
									check : check
								},
								success : function(param) {
									if (param.result == 'success') { // 보고싶어요
										check = 1;
										$('#like')
												.removeClass(
														'css-1tc9iuk-StylelessButton-ContentActionButton')
												.addClass(
														'css-15hndx7-StylelessButton-ContentActionButton');
										$('#off').hide();
										$('#on').show();
									} else if (param.result == 'cancel') { // 보고싶어요 취소
										check = 0;
										$('#like')
												.removeClass(
														'css-15hndx7-StylelessButton-ContentActionButton')
												.addClass(
														'css-1tc9iuk-StylelessButton-ContentActionButton');
										$('#on').hide();
										$('#off').show();
									}
								}
							});
				}
			}
		
		toggle = function() {
			if (check == 1) {
				$('#on').show();
				$('#off').hide();
			} else if (check == 0) {
				$('#off').show();
				$('#on').hide();
			}
		}
		toggle();
		
		calToggle = function() {
			if ($('#dateCheck').val() != 'noData') {
				$('#calOn').show();
				$('#calOff').hide();
			} else {
				$('#calOff').show();
				$('#calOn').hide();
			}
		}
		calToggle();
				
		/* 캘린더 */	
		
		/* 만약 이미 캘린더에 등록되어 있는 상태라면 그 날짜값을 불러온다 */
		let dateCheck = document.getElementById("dateCheck").value;
		/* 연,월,일로 분리 */
		let yearCheck = dateCheck.substr(0, 4);
		let monthCheck = dateCheck.substr(4, 2);
		let dayCheck = dateCheck.substr(6, 2);	
	
		const init = {
		    monList: ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12'],
		    dayList: ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'],
		    today: new Date(),
		    monForChange: new Date().getMonth(),
		    activeDate: new Date(),
		    getFirstDay: (yy, mm) => new Date(yy, mm, 1),
		    getLastDay: (yy, mm) => new Date(yy, mm + 1, 0),
		    nextMonth: function() {
		        let d = new Date();
		        d.setDate(1);
		        d.setMonth(++this.monForChange);
		        this.activeDate = d;
		        return d;
		    },
		    prevMonth: function() {
		        let d = new Date();
		        d.setDate(1);
		        d.setMonth(--this.monForChange);
		        this.activeDate = d;
		        return d;
		    },
		    addZero: (num) => (num < 10) ? '0' + num : num,
		    activeDTag: null,
		    getIndex: function(node) {
		        let index = 0;
		        while (node = node.previousElementSibling) {
		            index++;
		        }
		        return index;
		    }
		};
		
		const $calBody = document.querySelector('.cal-body');
		const $btnNext = document.querySelector('.btn-cal.next');
		const $btnPrev = document.querySelector('.btn-cal.prev');
		
		/**
		 * @param {number} date
		 * @param {number} dayIn
		 */
		function loadDate(date, dayIn) {
		    document.querySelector('.cal-date').textContent = date;
		    document.querySelector('.cal-day').textContent = init.dayList[dayIn];
		}
		
		/**
		 * @param {date} fullDate
		 */
		function loadYYMM(fullDate) {
		    let yy = fullDate.getFullYear();
		    let mm = fullDate.getMonth();
		    let firstDay = init.getFirstDay(yy, mm);
		    let lastDay = init.getLastDay(yy, mm);
		    let markToday; /* 이미 등록되어 있는 날짜가 있다면 표시해 주기 위한 변수 설정 */
		
			/* 등록되어 있는 날짜의 연,월이 현재 열람하고 있는 달력의 연,월과 일치하다면 */
		    if (init.addZero(mm + 1) === monthCheck && yy == yearCheck) {
		        markToday = dayCheck;
		    }
		    document.querySelector('.cal-month').textContent = init.monList[mm];
		    document.querySelector('.cal-year').textContent = yy;
		
		    let trtd = '';
		    let startCount;
		    let countDay = 0;
		    for (let i = 0; i < 6; i++) {
		        trtd += '<tr>';
		        for (let j = 0; j < 7; j++) {
		            if (i === 0 && !startCount && j === firstDay.getDay()) {
		                startCount = 1;
		            }
		            if (!startCount) {
		                trtd += '<td>'
		            } else {
		                let fullDate = yy + '.' + init.addZero(mm + 1) + '.' + init.addZero(countDay + 1);
		                trtd += '<td id="day" class="day';
		                trtd += (markToday && markToday == countDay + 1) ? ' dayMark" ' : '"';
		                trtd += ` data-date="${countDay + 1}" data-fdate="${fullDate}">`;
		            }
		            trtd += (startCount) ? ++countDay : '';
		            if (countDay === lastDay.getDate()) {
		                startCount = 0;
		            }
		            trtd += '</td>';
		        }
		        trtd += '</tr>';
		    }
		    $calBody.innerHTML = trtd;
		}
		
		/**
		 * @param {string} val
		 */
		function createNewList(val) {
		    let id = new Date().getTime() + '';
		    let yy = init.activeDate.getFullYear();
		    let mm = init.activeDate.getMonth() + 1;
		    let dd = init.activeDate.getDate();
		    const $target = $calBody.querySelector(`.day[data-date="${dd}"]`);
		
		    let date = yy + '.' + init.addZero(mm) + '.' + init.addZero(dd);
		
		    let eventData = {};
		    eventData['date'] = date;
		    eventData['memo'] = val;
		    eventData['complete'] = false;
		    eventData['id'] = id;
		    init.event.push(eventData);
		    $todoList.appendChild(createLi(id, val, date));
		}
		
		loadYYMM(init.today);
		loadDate(init.today.getDate(), init.today.getDay());
		
		$btnNext.addEventListener('click', () => loadYYMM(init.nextMonth()));
		$btnPrev.addEventListener('click', () => loadYYMM(init.prevMonth()));
		
		const dayMarkEl = document.querySelector('td');
		const classes = dayMarkEl.classList;
		
		$calBody.addEventListener('click', (e) => {
		    if (e.target.classList.contains('day')) {
		        if (init.activeDTag) {
		            init.activeDTag.classList.remove('day-active');
		        }
		        let day = Number(e.target.textContent);
		        loadDate(day, e.target.cellIndex);
		        if (!classes.contains('dayMark')) {
		            e.target.classList.add('day-active');
		        }
		        init.activeDTag = e.target;
		        init.activeDate.setDate(day);
		    }
		});	
		
});