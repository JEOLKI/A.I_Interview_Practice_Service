package com.aiinterview.board.dao;

import java.util.List;

import com.aiinterview.board.vo.BoardVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("boardMapper")
public interface BoardMapper {
	
	public List<BoardVO> retrieveList(int boardGbSq);
	
/*	List<BoardVO> getBoardList(int gubun_sq);
	
	List<BoardVO> getBoardPageList(PageVo pageVo);

	int getBoardTotalCnt(int gubun_sq);

	BoardVo getBoard(int board_sq);

	List<AtchFileVo> getAtchFileList(int board_sq);

	List<ReplyVo> getReplyList(int board_sq);
	
	int deleteBoard(int board_sq);

	int insertBoard(BoardVo boardVo);

	int insertAtchFile(AtchFileVo atchfileVo);

	int insertBoardChild(BoardVo boardVo);

	AtchFileVo getAtchFile(int atch_sq);

	int deleteAtchFile(int atch_sq);
		private int boardSq;			// 게시글 번호
	private int boardGbSq;			// 게시글 구분 번호
	private String boardTitle;		// 게시글 제목
	private String boardContent;	// 게시글 내용
	private String boardDate;		// 게시글 등록일자
	private String boardSt;			// 게시글 상태
	private int groupNo;			// 게시글 그룹 번호
	private int parentSq;			// 게시글 부모 번호
	private String memId;			// 회원 아이디
	public void create(BoardVO boardVO) throws Exception; 
	
	public BoardVO retrieve(BoardVO boardVO) throws Exception;
	
	public int update(BoardVO boardVO) throws Exception;
	
	public int delete(BoardVO boardVO) throws Exception;
	
	public List<BoardVO> retrievePagingList(BoardVO boardVO) throws Exception;
	
	public int retrievePagingListCnt(BoardVO boardVO) throws Exception;
	
	public List<BoardVO> retrieveList(BoardVO boardVO) throws Exception;


	int updateBoard(BoardVo boardVo);*/
}
